----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2021 16:45:55
-- Design Name: 
-- Module Name: Mux16_1_TB - Behavioral
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

entity Mux16_1_TB is
--  Port ( );
end Mux16_1_TB;

architecture Behavioral of Mux16_1_TB is

COMPONENT Mux16_1 IS
    Port(
        X : in STD_LOGIC_VECTOR(15 downto 0);
        S : in STD_LOGIC_VECTOR(3 downto 0);
        Y : out STD_LOGIC
       );
END COMPONENT;

signal X : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
signal S : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal Y : STD_LOGIC;
begin
    mux : Mux16_1 PORT MAP(
        X,S,Y
    );   
    
    test_process : process
        begin
            wait for 50 ns;
            X <= "0000000000000001";
            S <= "0000";
            wait for 50 ns;
            S <= "0011";
            wait for 50 ns;
            X <= "0000000000001000";
            wait for 50 ns;
            S <= "0100";
            X <= "0000000000010110";
            wait;
        end process;
    
end Behavioral;