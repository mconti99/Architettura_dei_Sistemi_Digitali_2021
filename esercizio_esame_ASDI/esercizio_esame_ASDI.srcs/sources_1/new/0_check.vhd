----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.12.2021 18:38:02
-- Design Name: 
-- Module Name: 0_check - Dataflow
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

entity zero_check is port(
    x : in std_logic_vector(7 downto 0);
    o : out std_logic
    );
end zero_check;

architecture Dataflow of zero_check is

begin
    o <= x(0) or x(1) or x(2) or x(3) or x(4) or x(5) or x(6) or x(7);

end Dataflow;
