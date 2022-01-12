----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2021 16:30:30
-- Design Name: 
-- Module Name: macchinaCombinatoria - Behavioral
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

entity macchinaCombinatoria is
    port(
    i : in std_logic_vector(3 downto 0);
    o : out std_logic_vector(2 downto 0));
end macchinaCombinatoria;

architecture Dataflow of macchinaCombinatoria is
signal ris1 : std_logic;
begin
    o(0) <= i(3) and i(2) and i(1) and i(0);
    o(1) <= i(3) or i(2) or i(1) or i(0);
    o(2) <= i(3) xor i(2) xor i(1) xor i(0);

end Dataflow;
