----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2021 18:32:24
-- Design Name: 
-- Module Name: Demux1_4_TB - Behavioral
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

entity Demux1_4_TB is
--  Port ( );
end Demux1_4_TB;

architecture Behavioral of Demux1_4_TB is
COMPONENT Demux1_4 IS
    Port(
        X : in STD_LOGIC;
        S : in STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0)
       );
END COMPONENT;
signal X : STD_LOGIC := '0';
signal S : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal Y : STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin

    Demux : Demux1_4 PORT MAP(
        X => X,
        S => S,
        Y => Y
       );
      
stim_proc: process
    begin
        wait for 100 ns;
        X <= '1';
        S <= "01";
        wait for 50 ns;
        X <= '1';
        S <= "10";
        wait for 50 ns;
        X <= '0';
        wait for 50 ns;
        S <= "11";
        X <= '1';
        wait;
    end process;
      
end Behavioral;