----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2021 15:47:21
-- Design Name: 
-- Module Name: Mux2_1_TB - Behavioral
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

entity Mux2_1_TB is
end Mux2_1_TB;

architecture Behavioral of Mux2_1_TB is
COMPONENT Mux2_1 IS
    Port(
        X : in STD_LOGIC_VECTOR(1 downto 0);
        S : in STD_LOGIC;
        Y : out STD_LOGIC
       );
END COMPONENT;
signal X : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal S : STD_LOGIC := '0';
signal Y : STD_LOGIC;
begin

    Mux : Mux2_1 PORT MAP(
        X => X,
        S => S,
        Y => Y
       );
      
stim_proc: process
    begin
        wait for 100 ns;
        X <= "01";
        wait for 50 ns;
        X <= "11";
        S <= '0';
        wait for 50 ns;
        X <= "10";
        wait for 50 ns;
        S <= '1';
        X <= "00";
        wait;
    end process;
      
end Behavioral;
