library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity ControlUnit is
    port(
        X1,X2,X3,X4 : in std_logic_vector(7 downto 0);
        s1,s2,s3,s4 : in std_logic;
        
        Y1,Y2,Y3,Y4 : out std_logic_vector(7 downto 0);
        s,d : out std_logic_vector(1 downto 0)
    );
end ControlUnit;

architecture Structural of ControlUnit is

signal selected : std_logic_vector(1 downto 0);

begin
    arb : entity work.Arbitro port map(
        s1 => s1, s2 => s2, s3 => s3, s4 => s4, selected => selected
    );
    
    Y4 <= X4 when selected = "11" else
          (others=>'0');
    Y3 <= X3 when selected = "10" else
          (others=>'0');    
    Y2 <= X2 when selected = "01" else
          (others=>'0');    
    Y1 <= X1 when selected = "00" else
          (others=>'0');
    
    with selected select
        s <= X4(7 downto 6) when "11",
             X3(7 downto 6) when "10",
             X2(7 downto 6) when "01",
             X1(7 downto 6) when "00",
             "--" when others;
            
             
    with selected select
        d <= X4(5 downto 4) when "11",
             X3(5 downto 4) when "10",
             X2(5 downto 4) when "01",
             X1(5 downto 4) when "00",
             "--" when others;
end Structural;
