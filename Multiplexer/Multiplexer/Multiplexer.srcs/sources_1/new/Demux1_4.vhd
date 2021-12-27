----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2021 17:02:14
-- Design Name: 
-- Module Name: Demux1_4 - Dataflow
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

entity Demux1_4 is
    Port(
        X : in STD_LOGIC;
        S : in STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0)
   );
end Demux1_4;

architecture Dataflow of Demux1_4 is

begin
with S select
    Y <= "000" & X when "00",
         "00" & X & "0" when "01",
         "0" & X & "00" when "10",
         X & "000" when "11",
         "----" when others;

end Dataflow;
