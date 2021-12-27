----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2021 11:44:06
-- Design Name: 
-- Module Name: SistemaHandshaking - Structural
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
library work;
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

entity SistemaHandshaking is port(
    clk : in std_logic;
    rst : in std_logic; 
    mode_selection : in std_logic; 
    start : in std_logic);
end SistemaHandshaking;

architecture Structural of SistemaHandshaking is

signal data : std_logic_vector(7 downto 0);
signal r : std_logic;
signal ack: std_logic;

begin
a : entity work.nodoa port map(
   clk=>clk, data_out=>data, start=>start, ack=>ack, r=>r, rst=>rst);
    
b : entity work.nodob port map(
    clk=>clk, data_in=>data, ack=>ack, r=>r, mode_selection=>mode_selection, rst=>rst);
    
end Structural;
