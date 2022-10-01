----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2021 00:25:00
-- Design Name: 
-- Module Name: Display - Structural
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

entity Display is
    generic(
    CLKIN_freq : integer :=100000000;
    CLKOUT_freq : integer :=500);
    port(
    clk : in std_logic;
    rst : in std_logic;
    value : in std_logic_vector(31 downto 0);
    enable: in std_logic_vector(7 downto 0);-- quali cifre abilitare
    dots : in std_logic_vector(7 downto 0);--quali punti visualizzare
    anodes : out std_logic_vector(7 downto 0);
    cathodes : out std_logic_vector(7 downto 0)
    );
end Display;

architecture Structural of Display is
signal counter : std_logic_vector(2 downto 0);
signal clock_filter_out : std_logic := '0';

component counter_mod8 port(
    clock: in std_logic;
    reset : in std_logic;
    enable: in std_logic;
    counter : out std_logic_vector(2 downto 0));
end component ;

component cathodes_manager port(
    counter: in std_logic_vector(2 downto 0);
    value : in std_logic_vector(31 downto 0);
    dots : in std_logic_vector(7 downto 0);
    cathodes: out std_logic_vector(7 downto 0));
end component;

component anodes_manager port(
    counter : in std_logic_vector(2 downto 0);
    enable_digit : in std_logic_vector(7 downto 0);
    anodes : out std_logic_vector(7 downto 0));
end component;

component clock_filter generic(
    CLKIN_freq : integer := 100000000;
    CLKOUT_freq : integer := 500);
    port(
    clock_in : in std_logic;
    reset : in std_logic;
    clock_out : out std_logic);
end component;

begin
clk_filter : clock_filter generic map(
    CLKIN_freq => clkin_freq, clkout_freq => clkout_freq)
    port map( clock_in=>CLK, reset => rst, clock_out => clock_filter_out);

counter_instance : counter_mod8 port map(
    clock=>CLK, enable=>clock_filter_out, reset=>rst, counter=>counter);

cathodes_instance: cathodes_manager port map(
    counter=>counter, value=>value, dots=>dots, cathodes=>cathodes);

anodes_instance : anodes_manager port map(
    counter=>counter, enable_digit=>enable, anodes=>anodes);

end Structural;
