----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2021 23:23:04
-- Design Name: 
-- Module Name: ShiftRegisterOnBoard - Structural
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

entity ShiftRegisterOnBoard is
    generic(
        N : integer := 8
    );
    port(
        clk : in std_logic;
        
        rst : in std_logic;
        enable : in std_logic;
        shifts : in std_logic_vector(1 downto 0);
        parallel_load : in std_logic;
        parallel_input : in std_logic_vector(N-1 downto 0);
        
        state : out std_logic_vector(N-1 downto 0)
    );
end ShiftRegisterOnBoard;

architecture Structural of ShiftRegisterOnBoard is
component variable_shift_register is
    generic(
        N : integer := 16
    );
    port(
        clk : in std_logic;
        
        rst : in std_logic;
        enable : in std_logic;
        shifts : in std_logic_vector(1 downto 0);
        parallel_load : in std_logic;
        parallel_input : in std_logic_vector(N-1 downto 0);
        
        state : out std_logic_vector(N-1 downto 0)
    );
end component;

component ButtonDebouncer is
    generic(
        CLK_PERIOD : integer := 10;
        btn_noise_time: integer :=6500000);
    port(
    clk : in std_logic;
    reset : in std_logic;
    btn : in std_logic;
    cleared_btn : out std_logic --dura quanto un colpo di clock
    );
end component;
signal cleared_e : std_logic;

begin
debenable : ButtonDebouncer generic map(
    CLK_PERIOD=>10,btn_noise_time=>650000000)
    port map(
    clk=>clk, reset=>'0', btn=>enable, cleared_btn=>cleared_e);

shift : variable_shift_register generic map(
    N=>8) port map(
    clk=>clk, rst=>rst, enable=>cleared_e, shifts=>shifts, parallel_load=>parallel_load,
    parallel_input=>parallel_input, state=>state);
end Structural;
