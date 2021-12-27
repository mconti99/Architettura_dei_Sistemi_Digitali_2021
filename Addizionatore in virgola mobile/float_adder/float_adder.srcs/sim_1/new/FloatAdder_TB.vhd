----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2021 21:02:08
-- Design Name: 
-- Module Name: FloatAdder_TB - Behavioral
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
library work;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FloatAdder_TB is
--  Port ( );
end FloatAdder_TB;

architecture Behavioral of FloatAdder_TB is
signal clk, start_b : std_logic;
signal op1, op2, res : std_logic_vector(31 downto 0);
begin
uut : entity work.floatadder port map(
    clk=>clk, start_b=>start_b, op1=>op1, op2=>op2, res=>res);
    
    clk_proc : process begin
    clk<= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
    end process;
    
    test_proc : process begin

    op1<='0' & "10000010" & "01000000000000000000000"; -- 7.02
    op2 <= '0' & "10001000" & "11111001000011001100110";-- -7.01
    start_b <= '1';
    wait for 20 ns;
    start_b<= '0';
    wait for 20 ns;
    wait;
    end process;

end Behavioral;
