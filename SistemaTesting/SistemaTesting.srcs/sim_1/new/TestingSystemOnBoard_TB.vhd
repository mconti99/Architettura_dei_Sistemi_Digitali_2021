

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity TestingSystemOnBoard_TB is
--  Port ( );
end TestingSystemOnBoard_TB;

architecture Behavioral of TestingSystemOnBoard_TB is
signal read : std_logic;
signal clk : std_logic;
signal reset : std_logic;--resetta la memoria
signal led : std_logic_vector(2 downto 0);
signal visual_b : std_logic;
signal switch_in : std_logic_vector(2 downto 0);
begin
    uut : entity work.testingsystemonboard port map(
        read=>read, clk=>clk, reset=>reset, led=>led, visual_b=>visual_b, switch_in=>switch_in);
    
    clk_proc: process begin
    clk<='0';
    wait for 5 ns;
    clk<='1';
    wait for 5 ns;
    end process;
    
    testing_proc: process begin
    wait for 5 ns;
    read<='1';
    reset<='0';
    wait for 20 ns;
    read<='0';
    wait;
    end process;
end Behavioral;
