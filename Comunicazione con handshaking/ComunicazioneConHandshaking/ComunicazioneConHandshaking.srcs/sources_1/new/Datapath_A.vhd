----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2021 22:35:23
-- Design Name: 
-- Module Name: Datapath_A - Structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Datapath_A is port(
    clk : in std_logic;
    
    inc_register : in std_logic;
    rst : in std_logic;
    buffer_write : in std_logic;
    mem_read : in std_logic;
    
    data_out : out std_logic_vector(15 downto 0);
    conteggio : out std_logic_vector(2 downto 0)
    ); 
end Datapath_A;

architecture Structural of Datapath_A is
component ROM is
    port(
    clk : in std_logic;
    reset : in std_logic;
    read: in std_logic;
    addr : in std_logic_vector(2 downto 0); 
    data : out std_logic_vector(15 downto 0));
end component;

component counter is
    generic(
        M : integer := 8
    );
    port(
        clk, rst, count, load : in std_logic;
        parallel_input : in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
        clk_out : out std_logic;
        Y : out std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0)
    );
end component;

component registro is
    generic(
        N : integer := 8
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        write : in std_logic;
        data_in : in std_logic_vector(N-1 downto 0);
        data_out : out std_logic_vector(N-1 downto 0)
        );        
end component;
signal addr : std_logic_vector(2 downto 0);
signal data : std_logic_vector(15 downto 0); 
begin
conteggio <= addr;
a_rom : rom port map(
    clk=>clk, reset=>'0', read=>mem_read, addr=>addr, data=>data); 
    
a_counter : counter generic map(
    M=>8)
    port map(
        clk=>clk, rst=>rst, count=>inc_register, load=>'0', parallel_input=>(others=>'0'), Y=>addr);

a_registro : registro generic map(
    N=>16)
    port map(
    clk=>clk, rst=>rst, write=>buffer_write, data_in=>data, data_out=>data_out);
    

end Structural;
