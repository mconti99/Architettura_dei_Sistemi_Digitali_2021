----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2021 11:00:18
-- Design Name: 
-- Module Name: Memory_TB - Behavioral
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

entity Memory_TB is
end Memory_TB;

architecture Behavioral of Memory_TB is
component Memory is
generic(
    N: integer := 32; --grandezza blocco di memoria
    M: integer := 8 --quanti blocchi di memoria
    );
    port(
    read : in std_logic;
    write : in std_logic;
    clk : in std_logic;
    input : in std_logic_vector(N-1 downto 0);
    output : out std_logic_vector(N-1 downto 0);
    address : in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0)
    );
end component;

signal read : std_logic;
signal write : std_logic;
signal clk : std_logic;
signal input : std_logic_vector(8-1 downto 0);
signal output : std_logic_vector(8-1 downto 0);
signal address : std_logic_vector(integer(ceil(log2(real(4))))-1 downto 0);

begin
uut : Memory generic map(
    M => 4, N=>8)
    port map(
    read=>read, write=>write, clk=>clk, input=>input, output=>output, address=>address);

clk_proc : process begin
    clk<='0';
    wait for 10 ns;
    clk<='1';
    wait for 10 ns;
end process;

mem_proc : process begin
    read<='0';
    write<='0';
    wait for 20 ns;
    address <= "00";
    input <= x"AA";
    read <='1';
    wait for 30 ns;
    input <= x"01";
    write <='1';
    read <='0';
    wait for 30 ns;
    write <='0';
    read <='1';
    wait;
end process;
end Behavioral;
