----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2021 20:58:42
-- Design Name: 
-- Module Name: TestingSystemOnBoard - Structural
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
library work;

entity TestingSystemOnBoard is
    port(
    read : in std_logic;
    clk : in std_logic;
    reset : in std_logic;--resetta la memoria
    visual_b : in std_logic;
    switch_in : in std_logic_vector(2 downto 0);
    led : out std_logic_vector(2 downto 0));
end TestingSystemOnBoard;

architecture Structural of TestingSystemOnBoard is 

signal counter_value : std_logic_vector(2 downto 0);
signal counter_inc : std_logic;
signal rom_enable :std_logic;
signal system_reset : std_logic;
signal mem_write : std_logic;
signal mem_read : std_logic;
signal cleared_read : std_logic;
signal cleared_visual : std_logic;
begin

cu : entity work.controlunit port map(
        read=>cleared_read, clk=>clk, reset=>reset, counter_value=>counter_value, 
        counter_inc=>counter_inc, rom_enable=>rom_enable, system_reset=>system_reset,
        mem_write=>mem_write, mem_read=>mem_read, visual_b=>cleared_visual);

ou : entity work.operatingunit port map(
        counter_inc=>counter_inc, rom_enable=>rom_enable, reset=>system_reset, 
        mem_read=>mem_read, mem_write=>mem_write, clk=>clk, counter_value=>counter_value,
        output=>led, switch_in=>switch_in);

debr : entity work.ButtonDebouncer generic map(
    CLK_PERIOD=>10, btn_noise_time=>650000000)
    port map(
    clk=>clk, reset=>reset, btn=>read, cleared_btn=>cleared_read);
    
debv: entity work.ButtonDebouncer generic map(
    CLK_PERIOD=>10, btn_noise_time=>650000000)
    port map(
    clk=>clk, reset=>reset, btn=>visual_b, cleared_btn=>cleared_visual);
end Structural;
