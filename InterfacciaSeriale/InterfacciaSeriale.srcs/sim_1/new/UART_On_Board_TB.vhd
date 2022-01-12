library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_on_board_TB is
end uart_on_board_TB;

architecture Behavioral of uart_on_board_TB is

component uart_on_board is
    port(
        start : in std_logic;
        reset : in std_logic;
        clk : in std_logic;
        leds : out std_logic_vector(7 downto 0)
    );
end component;

signal start : std_logic;
signal reset : std_logic;
signal clk : std_logic;
signal leds : std_logic_vector(7 downto 0);

begin
    uut : uart_on_board port map(
        start => start, reset => reset, clk => clk, leds => leds
    );
    
    clk_prc : process begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;
    
    signal_prc : process begin
        reset <= '1';
        wait for 0.01 ms;
        reset <= '0';
        start <= '1';
        wait for 0.01 ms;
        start <= '0';
        wait for 0.2 ms;
        start <= '1';
        wait for 0.02 ms;
        start <= '0';
        wait for 0.2 ms;
        start <= '1';
        wait for 0.02 ms;
        start <= '0';
        wait for 0.2 ms;
        start <= '1';
        wait for 0.02 ms;
        start <= '0';
        wait for 0.2 ms;
        start <= '1';
        wait for 0.02 ms;
        start <= '0';
        wait;
    end process;
end Behavioral;
