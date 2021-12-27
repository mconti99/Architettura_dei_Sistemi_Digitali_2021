----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2021 23:33:52
-- Design Name: 
-- Module Name: NodoA_TB - Behavioral
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

entity NodoA_TB is
end NodoA_TB;

architecture Behavioral of NodoA_TB is
component NodoA is port(--MASTER
    clk : in std_logic;
    rst : in std_logic;  
    data_out : out std_logic_vector(7 downto 0);
    start : in std_logic;
    ack : in std_logic;
    r : out std_logic);
end component;
signal clk : std_logic;
 
signal data_out :  std_logic_vector(7 downto 0);
signal start :  std_logic := '0';
signal ack : std_logic := '0';
signal r : std_logic;
signal rst : std_logic;
begin

    uut : nodoa port map(
        clk=>clk, data_out=>data_out, start=>start, ack=>ack,r=>r, rst=>rst);
        
clock_tb: process begin
    clk<='0';
    wait for 5 ns;
    clk<='1';
    wait for 5 ns;
end process;
nodoa_tb : process begin
    rst <= '1';
    wait for 50 ns;
    rst <= '0';
    start<='1';
    wait for 20 ns;
    ack <='1';
    wait for 20 ns;
    ack <='0';
    wait for 25 ns;
    ack <= '1';
    wait for 20 ns;
    ack <='0';
    wait for 20 ns;
    ack <= '1';
    wait for 20 ns;
    ack <='0';
    wait for 20 ns;
    ack <= '1';
    wait for 20 ns;
    ack <='0';
    wait for 20 ns;
    ack <= '1';
    wait for 20 ns;
    ack <='0';
    wait for 20 ns;
    ack <= '1';
    wait for 20 ns;
    ack <='0';
    wait for 20 ns;
    ack <= '1';
    wait for 20 ns;
    ack <='0';
    wait for 20 ns;
    ack <='0';
    wait for 20 ns;
    ack <= '1';
    wait for 20 ns;
    ack <='0';
    wait for 20 ns;
    ack <= '1';
    wait for 20 ns;
    ack <='0';
    wait for 20 ns;
    ack <= '1';
    wait for 20 ns;
    ack <='0';
    wait for 20 ns;
    ack <='1';
    wait for 20 ns;
    ack <='0';
    wait for 20 ns;
    ack <='1';
    wait for 20 ns;
    ack <='0';
    wait for 20 ns;
    ack <='1';
    wait for 20 ns;
    ack <='0';
    wait for 20 ns;
    ack <='1';
    wait for 20 ns;
    ack <='0';
    start <= '0';
    wait;
end process;

end Behavioral;
