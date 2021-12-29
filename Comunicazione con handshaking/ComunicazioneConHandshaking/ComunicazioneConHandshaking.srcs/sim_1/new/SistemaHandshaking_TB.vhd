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
component SistemaHandshaking is port(
    clk : in std_logic;
    --rst : in std_logic;  
    start : in std_logic;
    in_switch : in std_logic_vector(2 downto 0);
    visual_b : in std_logic;
    anodes : out std_logic_vector(7 downto 0);
    cathodes : out std_logic_vector(7 downto 0));
end component;
signal clk : std_logic;
signal start : std_logic;
signal in_switch :  std_logic_vector(2 downto 0);
signal visual_b : std_logic;
signal anodes :  std_logic_vector(7 downto 0);
signal cathodes : std_logic_vector(7 downto 0);
begin
uut : sistemahandshaking port map(
    clk=>clk, start=>start, in_switch=>in_switch, visual_b=>visual_b, anodes=>anodes, cathodes=>cathodes);
    
clk_proc: process begin
    clk<='1';
    wait for 1 ns;
    clk<='0';
    wait for 1 ns;
end process;

hs_proc : process begin
    wait for 200 ns;
    start<='1';
    in_switch <= "001";
    visual_b<='0';
    wait for 2000 ns;
    visual_b<='1';
    start <='0';
    wait;
end process;
end Behavioral;
