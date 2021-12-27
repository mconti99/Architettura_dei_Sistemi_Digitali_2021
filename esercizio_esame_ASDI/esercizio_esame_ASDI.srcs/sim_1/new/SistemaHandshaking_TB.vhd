----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2021 11:53:55
-- Design Name: 
-- Module Name: SistemaHandshaking_TB - Behavioral
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
library work;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SistemaHandshaking_TB is
--  Port ( );
end SistemaHandshaking_TB;

architecture Behavioral of SistemaHandshaking_TB is

signal clk : std_logic;
signal start : std_logic;
signal mode_selection : std_logic;
signal rst : std_logic;

begin
uut : entity work.sistemahandshaking port map(
    clk=>clk, mode_selection=>mode_selection, start=>start, rst=>rst);
    
clk_proc: process begin
    clk<='1';
    wait for 1 ns;
    clk<='0';
    wait for 1 ns;
end process;

hs_proc : process begin
    rst <= '1';
    wait for 200 ns;
    rst <= '0';
    start<='1';
    mode_selection<='1';
    wait for 2000 ns;
    start <='0';
    mode_selection<='0';
    wait for 50 ns;
    start<='1';
    wait;
end process;
end Behavioral;
