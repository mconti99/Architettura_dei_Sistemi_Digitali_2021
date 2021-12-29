----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2021 11:19:08
-- Design Name: 
-- Module Name: NodoB_TB - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NodoB_TB is
end NodoB_TB;

architecture Behavioral of NodoB_TB is
component nodob is port(
    clk : in std_logic;
    --rst : in std_logic;  
    msg : in std_logic_vector(15 downto 0);
    ack : out std_logic;
    r : in std_logic);
end component;

signal clk : std_logic;
signal msg : std_logic_vector(15 downto 0);
signal ack : std_logic;
signal r: std_logic;

begin
uut: nodob port map(
    clk=>clk, msg=>msg, ack=>ack, r=>r);
    
clk_proc : process begin
    wait for 5 ns;
    clk<='1';
    wait for 5 ns;
    clk<='0';
end process;

nodob_proc : process begin
    msg<=x"0001";
    r<='1';
    wait for 300 ns;
    r<='0';
    wait for 100 ns;
    msg<=x"0010";
    r<='1';
    wait for 300 ns;
    r<='0';
    wait for 100 ns;
    msg<=x"0011";
    r<='1';
    wait for 300 ns;
    r<='0';
    wait for 100 ns;
    msg<=x"0100";
    r<='1';
    wait for 300 ns;
    r<='0';
    wait;
end process;
end Behavioral;
