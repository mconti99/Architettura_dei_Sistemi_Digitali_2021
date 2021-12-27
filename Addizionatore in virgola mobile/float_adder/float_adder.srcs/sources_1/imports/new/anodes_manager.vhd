----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2021 16:19:09
-- Design Name: 
-- Module Name: anodes_manager - Behavioral
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

entity anodes_manager is
    port(
    counter : in std_logic_vector(2 downto 0);--iscota del contatore
    enable_digit : in std_logic_vector(7 downto 0);--chiarifica se voglio visualizzare o no una cifra
    anodes : out STD_logic_vector(7 downto 0));--uno per ciascun anodo
end anodes_manager;

architecture Behavioral of anodes_manager is
signal anodes_switching : std_logic_vector(7 downto 0) := (others => '0');
begin

anodes <= not anodes_switching or not enable_digit; --or di due not = nand
anodes_process: process(counter) begin
    --a seconda del valore di counter le cifre si illuminano una alla volta da destra a sinistra
    case counter is 
        when "000" => anodes_switching <= "00000001";
        when "001" => anodes_switching <= "00000010";
        when "010" => anodes_switching <= "00000100";
        when "011" => anodes_switching <= "00001000";
        when "100" => anodes_switching <= "00010000";
        when "101" => anodes_switching <= "00100000";
        when "110" => anodes_switching <= "01000000";
        when "111" => anodes_switching <= "10000000";
        when others => anodes_switching <= (others => '0');
    end case;
end process;

end Behavioral;
