----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2021 11:09:12
-- Design Name: 
-- Module Name: NodoB - Structural
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

entity NodoB is port(
    clk : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    ack : out std_logic;
    mode_selection : in std_logic;
    rst : in std_logic;
    r : in std_logic);
end NodoB;

architecture Structural of NodoB is 
component ControlUnit_B is port(
    r : in std_logic;
    clk: in std_logic;
    conteggio : in std_logic_vector(2 downto 0);    
    reset : in std_logic;

    reset_system : out std_logic;
    inc_cont_mem : out std_logic;
    mem_write : out std_logic;
    buffer1_write : out std_logic;
    buffer2_write : out std_logic;
    inc_cont_str : out std_logic;
  
    ack : out std_logic);
end component;

component OperativeUnit_B is port(
    clk : in std_logic;
    
    inc_cont_mem : in std_logic;
    rst : in std_logic;
    mem_write : in std_logic;
    buffer1_write : in std_logic;
    buffer2_write : in std_logic;
    mode_selection: in std_logic;
    inc_cont_str : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    
    conteggio : out std_logic_vector(2 downto 0));    
end component;

signal inc_cont_mem : std_logic;
signal mem_write :  std_logic;
signal buffer1_write : std_logic;
signal buffer2_write : std_logic;
signal inc_cont_str : std_logic;
signal conteggio : std_logic_vector(2 downto 0);
signal reset_system : std_logic;
begin
controlunit : ControlUnit_B port map(
    r=>r, clk=>clk, conteggio=>conteggio, inc_cont_mem=>inc_cont_mem,
    mem_write=>mem_write, buffer1_write=>buffer1_write, 
    buffer2_write=>buffer2_write, inc_cont_str=>inc_cont_str,
    ack=>ack, reset=>rst, reset_system=>reset_system);

operativeunit : OperativeUnit_B port map(
    clk=>clk, rst=>reset_system, conteggio=>conteggio, inc_cont_mem=>inc_cont_mem,
    mem_write=>mem_write, buffer1_write=>buffer1_write, 
    buffer2_write=>buffer2_write, inc_cont_str=>inc_cont_str,
    data_in=>data_in, mode_selection=>mode_selection);

end Structural;
