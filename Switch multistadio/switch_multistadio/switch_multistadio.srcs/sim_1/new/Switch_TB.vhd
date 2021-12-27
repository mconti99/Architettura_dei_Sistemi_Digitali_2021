
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity Switch_TB is
end Switch_TB;

architecture Behavioral of Switch_TB is

signal i1 : std_logic_vector(7 downto 0);
signal i2 : std_logic_vector(7 downto 0);
signal o1 : std_logic_vector(7 downto 0);
signal o2 : std_logic_vector(7 downto 0);
signal s : std_logic;
signal d : std_logic;

begin
    sw : entity work.Switch port map(
        in1 => i1, in2 => i2, s=>s, d=>d, out1=>o1, out2=>o2
   );
   
   in_prc : process begin
        i1 <= x"1A";
        i2 <= x"13";
        s <= '0';
        d <= '0';
        wait for 50 ns;
        s <= '1';
        wait for 50 ns;
        d <= '1';
        wait;
   end process;
end Behavioral;
