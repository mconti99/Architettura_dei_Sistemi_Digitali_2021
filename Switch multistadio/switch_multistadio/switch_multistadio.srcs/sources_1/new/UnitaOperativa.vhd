library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;


entity UnitaOperativa is
    port(
        s, d : in std_logic_vector(1 downto 0);
        M1, M2, M3, M4 : in std_logic_vector(7 downto 0);
        O1, O2, O3, O4 : out std_logic_vector(7 downto 0)
    );
end UnitaOperativa;

architecture Structural of UnitaOperativa is

type connection_type is array(7 downto 0) of std_logic_vector(7 downto 0);

signal conn00, conn01, conn10, conn11 : std_logic_vector(7 downto 0);

begin

     sw00 : entity work.Switch port map(
            in1 => M1, in2=> M2, out1=>conn00, out2=>conn01, s=>s(0), d=>d(1) 
     );
     sw10 : entity work.Switch port map(
            in1 => M3, in2=> M4, out1=>conn10, out2=>conn11, s=>s(0), d=>d(1) 
     );
     sw01 : entity work.Switch port map(
            in1 => conn00, in2=> conn10, out1=>O1, out2=>O2, s=>s(1), d=>d(0) 
     );
     sw11 : entity work.Switch port map(
            in1 => conn01, in2=> conn11, out1=>O3, out2=>O4, s=>s(1), d=>d(0) 
     );   
    
end Structural;
