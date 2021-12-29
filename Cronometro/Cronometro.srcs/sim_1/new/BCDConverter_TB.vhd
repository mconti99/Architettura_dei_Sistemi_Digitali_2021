----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.11.2021 16:02:17
-- Design Name: 
-- Module Name: BCDConverter_TB - Behavioral
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

entity BCDConverter_TB is
--  Port ( );
end BCDConverter_TB;

architecture Behavioral of BCDConverter_TB is
    component BCDConverter is
    port(
        x : in std_logic_vector(5 downto 0);
        y : out std_logic_vector(7 downto 0));
    end component;
    
    signal x : std_logic_vector(5 downto 0);
    signal y : std_logic_vector(7 downto 0);
begin
    uut : BCDConverter port map(
        x => x, y => y);
    prc : process
    begin
    wait for 10 ns;
    x <= "001011";
    wait for 10 ns;
    x <= "111011";
    wait for 10 ns;
    x <= "000000";
    wait;
    end process;
end Behavioral;
