----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2021 16:04:09
-- Design Name: 
-- Module Name: counter_mod8 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
--usato per scorrere le cifre da visualizzare
entity counter_mod8 is
    port(
    clock :in std_logic;
    reset : in std_logic;
    enable: in std_logic; --enable viene dal divisore di frequenza
    counter : out std_logic_vector(2 downto 0)
    );
end counter_mod8;

architecture Behavioral of counter_mod8 is
signal c: std_logic_vector(2 downto 0) := (others => '0');
begin
counter <= c;

counter_process:process(clock) begin
    if(rising_edge(clock)) then
        if(reset='1') then
            c <= (others=>'0');
        elsif(enable='1') then
            c<=std_logic_vector(unsigned(c)+1);
        end if;
    end if;
end process;

end Behavioral;
