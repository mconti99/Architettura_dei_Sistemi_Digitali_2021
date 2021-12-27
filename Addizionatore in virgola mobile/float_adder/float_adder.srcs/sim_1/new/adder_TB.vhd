library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity adder_TB is
end adder_TB;

architecture Behavioral of adder_TB is

signal a : std_logic_vector(7 downto 0);
signal b : std_logic_vector(7 downto 0);
signal res : std_logic_vector(7 downto 0);
signal sub : std_logic;

begin
    uut : entity work.ripple_carry_adder generic map(
        N=>8
    ) port map(
        a=>a, b=>b, res=>res, sub=>sub 
    );
    
    process begin
        a <= x"1A";
        b <= x"1C";
        sub <= '0';
        wait for 20 ns;
        sub <= '1';
        wait;
    end process;

end Behavioral;
