library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity SwitchMultistadio is
    port(
        X1,X2,X3,X4 : in std_logic_vector(7 downto 0);
        s1,s2,s3,s4 : in std_logic;
        
        Y1,Y2,Y3,Y4 : out std_logic_vector(7 downto 0)
    );
end SwitchMultistadio;

architecture Structural of SwitchMultistadio is

signal s, d : std_logic_vector(1 downto 0);
signal M1,M2,M3,M4 : std_logic_vector(7 downto 0);

begin
    cu : entity work.ControlUnit port map(
        X1=>X1, X2=>X2, X3=>X3, X4=>X4,
        s1=>s1, s2=>s2, s3=>s3, s4=>s4,
        Y1=>M1, Y2=>M2, Y3=>M3, Y4=>M4,
        s=>s, d=>d
    );
    
    dp : entity work.UnitaOperativa port map(
      s=>s, d=>d,
      M1=>M1,M2=>M2, M3=>M3, M4=>M4,
      O1=>Y1, O2=>Y2, O3=>Y3, O4=>Y4
    );
end Structural;
