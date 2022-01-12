----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2021 18:18:27
-- Design Name: 
-- Module Name: ROM - Behavioral
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM is
    port(
    clk : in std_logic;
    reset : in std_logic;
    read: in std_logic;
    addr : in std_logic_vector(2 downto 0); 
    data : out std_logic_vector(7 downto 0));
end ROM;

architecture Behavioral of ROM is
type rom_type is array(7 downto 0) of std_logic_vector(7 downto 0);
signal ROM : rom_type := (
X"01",
X"10",
X"10",
X"66",
X"FF",
X"11",
X"69",
X"DD");

begin
process(CLK) begin
    if rising_edge(CLK) then
        if (ReSeT='1') then
            DATA <= ROM(conv_integer("000")); --valore di default
        elsif(READ ='1') then
            DATA <= ROM(conv_integer(ADDR));
        end if;
    end if;
end process;

end Behavioral;
