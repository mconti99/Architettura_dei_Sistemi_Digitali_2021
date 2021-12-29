----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.12.2021 01:43:12
-- Design Name: 
-- Module Name: orologio_TB - Behavioral
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

entity orologio_TB is
--  Port ( );
end orologio_TB;

architecture Behavioral of orologio_TB is
component orologio is
    port(
        clk, rst, load, count : in std_logic;
        sec_in : in std_logic_vector(5 downto 0);
        min_in : in std_logic_vector(5 downto 0);
        hour_in : in std_logic_vector(4 downto 0);
        
        sec : out std_logic_vector(5 downto 0);
        min : out std_logic_vector(5 downto 0);
        hour : out std_logic_vector(4 downto 0)
    );
end component;

signal clk : std_logic; 
signal rst : std_logic;
signal load: std_logic; 
signal count : std_logic;
signal sec_in : std_logic_vector(5 downto 0);
signal min_in : std_logic_vector(5 downto 0);
signal hour_in : std_logic_vector(4 downto 0);  
signal sec : std_logic_vector(5 downto 0);
signal min : std_logic_vector(5 downto 0);
signal hour : std_logic_vector(4 downto 0);
begin
uut : orologio port map(
    clk=>clk, rst=>rst, load=>load, count=>count, sec_in=>sec_in, min_in=>min_in, hour_in=>hour_in,
    sec=>sec, min=>min, hour=>hour);
    
clk_proc : process begin
    clk<='0';
    wait for 10 ns;
    clk<='1';
    wait for 10 ns;
end process;

clock_proc : process begin
    rst <= '1';
    wait for 50 ns;
    rst <= '0';
    count <= '1';
    wait for 200 ns;
    count <= '0';
    sec_in <= "000000";
    min_in <= "011010";
    hour_in <= "10011";
    load <= '1';
    wait for 50 ns;
    count <= '1';
    wait for 800 ns;
    rst <= '1';
    
    wait;
end process;

end Behavioral;
