library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity abs_TB is
end abs_TB;

architecture Behavioral of abs_TB is

signal X,Y : std_logic_vector(7 downto 0);

begin
    uut : entity work.abs_value generic map(
        N=>8
    ) port map(
        X=>X, Y=>Y
    );
    
    process begin
        X <= "01111111";
        wait for 20 ns;
        X <= "11111111";
        wait for 20 ns;
        X <= "10000001";
        wait;
    end process;

end Behavioral;
