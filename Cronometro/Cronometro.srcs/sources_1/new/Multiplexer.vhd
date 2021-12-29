----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2021 11:16:31
-- Design Name: 
-- Module Name: Multiplexer - Behavioral
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

entity Multiplexer is
    generic(
    N : integer := 32);
    port(
    in1 : in std_logic_vector(N-1 downto 0);
    in2: in std_logic_vector(N-1 downto 0);
    o: out std_logic_vector(N-1 downto 0);
    s : in std_logic
    );
end Multiplexer;

architecture Behavioral of Multiplexer is

begin
with s select
    o <= in1 when '0',
         in2 when '1';

end Behavioral;
