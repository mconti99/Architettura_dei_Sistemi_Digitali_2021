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
    --rst : in std_logic;  
    msg : in std_logic_vector(15 downto 0);
    ack : out std_logic;
    r : in std_logic;
    visual_b : in std_logic;
    in_switch : in std_logic_vector(2 downto 0);
    anodes : out std_logic_vector(7 downto 0);
    cathodes : out std_logic_vector(7 downto 0));
end NodoB;

architecture Structural of NodoB is 
component ControlUnit_B is port(
    r : in std_logic;
    clk: in std_logic;
    visual_b : in std_logic;
    
    inc_register : out std_logic;
    reset_datapath : out std_logic;
    buffer_write : out std_logic;
    msg_read : out std_logic;
    mem_read : out std_logic;
    mem_write : out std_logic;
    enable_visore : out std_logic;
    switch_mode : out std_logic;
    
    ack : out std_logic);
end component;

component Datapath_B is port(
    clk : in std_logic;
    
    inc_register : in std_logic;
    rst : in std_logic;
    buffer_write : in std_logic;
    msg_read : in std_logic;
    mem_read : in std_logic;
    mem_write : in std_logic;
    enable_visore : in std_logic;
    switch_mode : in std_logic;
    
    msg_in : in std_logic_vector(15 downto 0);
    in_switch : in std_logic_vector(2 downto 0);
    
    anodes : out std_logic_vector(7 downto 0);
    cathodes : out std_logic_vector(7 downto 0));
end component;

signal inc_register : std_logic;
signal buffer_write : std_logic;
signal msg_read : std_logic;
signal mem_read : std_logic;
signal mem_write : std_logic;
signal enable_visore : std_logic;
signal switch_mode : std_logic;
begin
datapath : datapath_B port map(
    clk=>clk, inc_register=>inc_register, rst=>'0', buffer_write=>buffer_write, 
    msg_read=>msg_read, mem_read=>mem_read, mem_write=>mem_write, 
    msg_in=>msg, anodes=>anodes, cathodes=>cathodes, in_switch=>in_switch, enable_visore=>enable_visore,
    switch_mode=>switch_mode);

control : controlunit_b port map(
    r=>r, clk=>clk, inc_register=>inc_register,visual_b=>visual_b,
    buffer_write=>buffer_write, msg_read=>msg_read, mem_read=>mem_read,
    mem_write=>mem_write, ack=>ack, enable_visore=>enable_visore, switch_mode=>switch_mode);

end Structural;
