library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;
entity nodo_A is 
    port(
        clk : in std_logic;
        rst : in std_logic;
        start : in std_logic;
        
        TXD : out std_logic 
    );
end nodo_A;

architecture Structural of nodo_A is

signal WR : std_logic;
signal sys_rst : std_logic;
signal rom_out : std_logic_vector(7 downto 0);
signal countertorom : std_logic_vector(2 downto 0);
signal inc_register : std_logic;
signal TBE : std_logic;

begin
    contA : entity work.counter generic map(M=>8)
        port map(
            clk=>clk, rst=>rst, count=>inc_register, load=>'0',
            parallel_input=>(others=>'0'), Y=>countertorom);
        
    romA : entity work.rom port map(
        clk=>clk, reset=>rst, read=>'1',
        addr=>countertorom, data=>rom_out);

    cu : entity work.A_CU port map(
        clk => clk, start => start, reset => rst,
        TBE => TBE, WR => WR,
        sys_rst=>sys_rst, inc_register=>inc_register
    );  

    dp : entity work.UARTcomponent port map (
		TXD=>TXD, RXD=>'1',  CLK => CLK,
		DBIN=>rom_out,TBE=> TBE,RD =>'1',WR=>WR,RST=>sys_rst
    );
end Structural;