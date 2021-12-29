----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2021 23:16:44
-- Design Name: 
-- Module Name: NodoA - Structural
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

entity NodoA is port(--MASTER
    clk : in std_logic;
    --rst : in std_logic;  
    data_out : out std_logic_vector(15 downto 0);
    start : in std_logic;
    ack : in std_logic;
    r : out std_logic);
end NodoA;

architecture Structural of NodoA is
component datapath_a is port(
    clk : in std_logic;
    
    inc_register : in std_logic;
    rst : in std_logic;
    buffer_write : in std_logic;
    mem_read : in std_logic;
    
    data_out : out std_logic_vector(15 downto 0);
    conteggio : out std_logic_vector(2 downto 0));
end component;

component ControlUnit_A is port(
    clk : in std_logic;
    start : in std_logic;
    ack : in std_logic;
    r : out std_logic;
    conteggio : in std_logic_vector(2 downto 0);
    inc_register : out std_logic;
    buffer_write : out std_logic;
    mem_read : out std_logic;
    reset_datapath : out std_logic);
end component;

signal inc_register : std_logic;
signal buffer_write : std_logic;
signal mem_read : std_logic;
signal conteggio : std_logic_vector(2 downto 0);
signal reset_datapath : std_logic;
begin

a_controlunit : controlunit_a port map(
    clk=>clk, start=>start, ack=>ack, r=>r, conteggio=>conteggio,
    inc_register=>inc_register, buffer_write=>buffer_write,
    reset_datapath=>reset_datapath, mem_read=>mem_read);

a_datapath : Datapath_a port map(
    clk=>clk, inc_register=>inc_register, rst=>reset_datapath, buffer_write=>buffer_write,
    data_out=>data_out, mem_read=>mem_read, conteggio=>conteggio);

end Structural;
