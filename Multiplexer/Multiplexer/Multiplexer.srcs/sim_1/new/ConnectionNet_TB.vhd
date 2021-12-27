----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2021 18:40:37
-- Design Name: 
-- Module Name: ConnectionNet_TB - Behavioral
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

entity ConnectionNet_TB is
--  Port ( );
end ConnectionNet_TB;

architecture Behavioral of ConnectionNet_TB is

COMPONENT ConnectionNet IS
    Port(
        X : in STD_LOGIC_VECTOR(15 downto 0);
        S : in STD_LOGIC_VECTOR(3 downto 0);
        D : in STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0)
       );
END COMPONENT;

signal X : STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
signal S : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal D : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal Y : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
    ConNet : ConnectionNet PORT MAP(
        X,S,D,Y
    );   
    
    test_process : process
        begin
            wait for 50 ns;
            X <= "0000000000000001";
            S <= "0000";
            D <= "00";
            wait for 50 ns;
            S <= "0011";
            D <= "01";
            wait for 50 ns;
            X <= "0000000000001000";
            D <= "11";
            wait for 50 ns;
            S <= "0100";
            X <= "0000000000010110";
            D <= "01";
            wait for 50 ns;
            X <= "1010101010101010";
            S <= "1110";
            D <= "00";
            wait;
        end process;

end Behavioral;