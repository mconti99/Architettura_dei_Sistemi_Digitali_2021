library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity uart_on_board is
    port(
        start : in std_logic;
        reset : in std_logic;
        clk : in std_logic;
        leds : out std_logic_vector(7 downto 0)
    );
end uart_on_board;

architecture Structural of uart_on_board is

signal data_line : std_logic;
signal start_b : std_logic;
begin

    startdeb : entity work.ButtonDebouncer generic map(
        clk_period=>10, btn_noise_time=>650000000)
        port map(
        clk=>clk, reset=>'0',
        btn=>start, cleared_btn=>start_b
    );
    n_A : entity work.nodo_A port map(
        clk => clk, rst => reset, 
        TXD => data_line, start => start_b
    );

    n_B : entity work.nodo_B port map(
        clk => clk, rst => reset,
        RXD => data_line, dato => leds,
        start=>start_b
    );
end Structural;
