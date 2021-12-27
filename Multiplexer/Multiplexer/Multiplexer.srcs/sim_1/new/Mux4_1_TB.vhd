----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2021 16:11:44
-- Design Name: 
-- Module Name: Mux4_1_TB - Behavioral
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

entity Mux4_1_TB is
end Mux4_1_TB;

architecture Behavioral of Mux4_1_TB is

COMPONENT Mux4_1 IS
    Port(
        X : in STD_LOGIC_VECTOR(3 downto 0);
        S : in STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC
       );
END COMPONENT;

signal X : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal S : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal Y : STD_LOGIC;
begin
    mux : Mux4_1 port map(
        X,S,Y
    );   
    
    test_process : process
        begin
            wait for 50 ns;
            X <= "0001";
            S <= "01";
            wait for 50 ns;
            S <= "11";
            wait for 50 ns;
            X <= "1011";
            S <= "10";
            wait for 50 ns;
            S <= "00";
            wait;
        end process;
    
end Behavioral;
