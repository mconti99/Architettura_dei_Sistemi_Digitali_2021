library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity NodoA is port(--MASTER
    clk : in std_logic; 
    data_out : out std_logic_vector(7 downto 0);
    start : in std_logic;
    rst : in std_logic;
    ack : in std_logic;
    r : out std_logic);
end NodoA;

architecture Structural of NodoA is
component OperativeUnit_A is port(
    clk : in std_logic;
    
    inc_register : in std_logic;
    reset : in std_logic;
    mem_read : in std_logic;
    
    data_out : out std_logic_vector(7 downto 0);
    conteggio : out std_logic_vector(2 downto 0));
end component;

component ControlUnit_A is port(
    clk : in std_logic;
    start : in std_logic;
    rst : in std_logic;
    ack : in std_logic;
    r : out std_logic;
    conteggio : in std_logic_vector(2 downto 0);
    inc_register : out std_logic;
    mem_read : out std_logic;
    reset_system : out std_logic);
end component;

signal inc_register : std_logic;
signal buffer_write : std_logic;
signal mem_read : std_logic;
signal conteggio : std_logic_vector(2 downto 0);
signal reset_system : std_logic;
begin

a_controlunit : controlunit_a port map(
    clk=>clk, start=>start, ack=>ack, r=>r, conteggio=>conteggio,
    inc_register=>inc_register,
    reset_system=>reset_system, mem_read=>mem_read, rst=>rst);

a_datapath : OperativeUnit_a port map(
    clk=>clk, inc_register=>inc_register, reset=>reset_system,
    data_out=>data_out, mem_read=>mem_read, conteggio=>conteggio);

end Structural;
