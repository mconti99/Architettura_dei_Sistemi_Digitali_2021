----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2021 11:44:06
-- Design Name: 
-- Module Name: SistemaHandshaking - Structural
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SistemaHandshaking is port(
    clk : in std_logic;
    --rst : in std_logic;  
    start : in std_logic;
    in_switch : in std_logic_vector(2 downto 0);
    visual_b : in std_logic;
    anodes : out std_logic_vector(7 downto 0);
    cathodes : out std_logic_vector(7 downto 0));
end SistemaHandshaking;

architecture Structural of SistemaHandshaking is
component NodoA is port(--MASTER
    clk : in std_logic;
    --rst : in std_logic;  
    data_out : out std_logic_vector(15 downto 0);
    start : in std_logic;
    ack : in std_logic;
    r : out std_logic);
end component;

component NodoB is port(
    clk : in std_logic;
    --rst : in std_logic;  
    msg : in std_logic_vector(15 downto 0);
    ack : out std_logic;
    r : in std_logic;
    visual_b : in std_logic;
    in_switch : in std_logic_vector(2 downto 0);
    anodes : out std_logic_vector(7 downto 0);
    cathodes : out std_logic_vector(7 downto 0));
end component;

component counter is
    generic(
        M : integer := 8
    );
    port(
        clk, rst, count, load : in std_logic;
        parallel_input : in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
        clk_out : out std_logic;
        Y : out std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0)
    );
end component;

component ButtonDebouncer is generic(
        CLK_PERIOD : integer := 10;
        btn_noise_time: integer :=6500000);
    port(
    clk : in std_logic;
    reset : in std_logic;
    btn : in std_logic;
    cleared_btn : out std_logic --dura quanto un colpo di clock
    );
end component;

signal data_out : std_logic_vector(15 downto 0);
signal r : std_logic;
signal ack: std_logic;
signal clk1 : std_logic;
signal clk2 : std_logic;
signal cleared_visual : std_logic;
signal cleared_start : std_logic;

begin
a : nodoa port map(
    clk=>clk1, data_out=>data_out, start=>cleared_start, ack=>ack, r=>r);
    
b : nodob port map(
    clk=>clk2, msg=>data_out, ack=>ack, r=>r, visual_b=>cleared_visual, anodes=>anodes, cathodes=>cathodes,
    in_switch=>in_switch);
    
c1 : counter generic map(
    M=>2)
    port map(
    clk=>clk, rst=>'0', count=>'1', load=>'0', clk_out=>clk1, parallel_input=>(others=>'0'));
    
c2 : counter generic map(
    M=>3)
    port map(
    clk=>clk, rst=>'0', count=>'1', load=>'0', clk_out=>clk2, parallel_input=>(others=>'0'));

debs : ButtonDebouncer generic map(
        CLK_PERIOD=>10, btn_noise_time=>650000000)
        port map(
        clk=>clk, reset=>'0', btn=>start, cleared_btn=>cleared_start);
        
debv : ButtonDebouncer generic map(
        CLK_PERIOD=>10, btn_noise_time=>650000000)
        port map(
        clk=>clk, reset=>'0', btn=>visual_b, cleared_btn=>cleared_visual);
end Structural;
