library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;
entity nodo_B is
    port(
        clk : in std_logic;
        rst : in std_logic;
        start : in std_logic;
        RXD : in std_logic;
        dato : out std_logic_vector(7 downto 0)
    );
end nodo_B;

architecture Structural of nodo_B is

signal UARTtomem : std_logic_vector(7 downto 0);
signal RD : std_logic;
signal RDA : std_logic;
signal mem_in : std_logic;
signal rst_usart : std_logic;
signal countertomem : std_logic_vector(2 downto 0);
signal inc_register : std_logic;
signal mem_read : std_logic;

begin

    mem : entity work.memory generic map(N=>8, M=>8) 
        port map(
            clk=>clk, address=>countertomem, write=>mem_in,
            read=>mem_read, input=>UARTtomem, 
            output=>dato, rst=>rst);
    
    cont : entity work.counter generic map(M=>8)
        port map(
            clk=>clk, rst=>rst, 
            count=>inc_register, load=>'0', 
            parallel_input=>(others=>'0'), Y=>countertomem );
     
    uc : entity work.B_CU port map(
        clk => clk, RDA => RDA, rst => rst, 
        RD=>RD, mem_in => mem_in,
        rst_usart=>rst_usart, start=>start, 
        mem_read=>mem_read, inc_register=>inc_register
    );
    
    uart : entity work.UARTcomponent port map(
		RXD => RXD,CLK => CLK,DBIN => (others => '0'), 
		DBOUT => UARTtomem, RD => '0', WR => '0',
		RST=>rst_usart, RDA=>RDA
	);	

end Structural;