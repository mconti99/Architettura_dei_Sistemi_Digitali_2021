----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2021 16:06:23
-- Design Name: 
-- Module Name: Arbiter_TB - Behavioral
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

entity Arbiter_TB is
--  Port ( );
end Arbiter_TB;

architecture Behavioral of Arbiter_TB is

   COMPONENT Arbiter 
    Port(
        X : in STD_LOGIC_VECTOR(9 downto 0);
        Y : out STD_LOGIC_VECTOR(9 downto 0)
       );
    END COMPONENT;
    
signal input : STD_LOGIC_VECTOR(9 downto 0) := "0000000000";
signal output : STD_LOGIC_VECTOR(9 downto 0);
begin

    uut : Arbiter PORT MAP (
        X => input,
        Y => output
    );

stim_proc: process 
    begin 
        wait for 100 ns;
        
        input <= "1010101010";
        wait for 50 ns;
        input <= "0101011111";
        wait for 50 ns;
        input <= "0000101010";
        wait for 50 ns;
        input <= "0010111111";
        wait for 50 ns;
        input <= "0001110111";
        wait for 50 ns;
        input <= "0000000001";
        wait for 50 ns;
        input <= "0000010101";
        wait for 50 ns;
        input <= "0000000010";
        wait for 50 ns;
        input <= "1000000000";
        wait for 50 ns;
        input <= "0000000100";
        wait for 50 ns;
        input <= "0000000000";
        wait;
end process;
end Behavioral;
