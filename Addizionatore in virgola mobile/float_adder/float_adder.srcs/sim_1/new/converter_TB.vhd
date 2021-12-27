library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity converter_TB is
end converter_TB;

architecture Behavioral of converter_TB is

signal X : std_logic_vector(7 downto 0);
signal Y : std_logic_vector(8 downto 0);
signal sign : std_logic;

begin
    uut : entity work.converter generic map(
        N=>8
    ) port map (
        X=>X, sign=>sign, Y=>Y
    );
    
    process begin
        X <= "00000001";
        sign <= '1';
        wait for 20 ns;
        sign <= '0';
        X <= "11111111";
        wait for 20 ns;
        sign <= '1';
        wait;
    end process;
end Behavioral;
