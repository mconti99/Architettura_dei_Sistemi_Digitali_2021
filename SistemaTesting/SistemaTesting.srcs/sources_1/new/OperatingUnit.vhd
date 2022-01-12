----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2021 16:37:12
-- Design Name: 
-- Module Name: operatingUnit - Structural
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;
library work;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity operatingUnit is
    port(
    counter_inc : in std_logic;
    rom_enable: in std_logic;
    switch_in : in std_logic_vector(2 downto 0);
    reset : in std_logic;
    mem_read : in std_logic;
    mem_write: in std_logic;
    clk : in std_logic; 
    counter_value : out std_logic_vector(2 downto 0);--uscita del contatore
    output : out std_logic_vector(2 downto 0));--uscita della mem
end operatingUnit;

architecture Structural of operatingUnit is
signal countertorom : std_logic_vector(2 downto 0);
signal romtocomb : std_logic_vector(3 downto 0);
signal combtomem : std_logic_vector(2 downto 0);
signal mem_address : std_logic_vector(2 downto 0);

begin
    with mem_read select
        mem_address<=countertorom when '0',
                     switch_in when '1',
                     switch_in when others;
                     
    cnt : entity work.counter generic map(
        M=>8)
        port map(
        clk=>clk, rst=>reset, count=>counter_inc, load=>'0', parallel_input=>(others=>'0'), Y=>countertorom);
    
    counter_value<=countertorom;
    
    readonlymemory : entity work.rom PORT map(
        clk=>clk, reset=>reset, read=>rom_enable, addr=> countertorom, data=>romtocomb);
    
    comb : entity work.macchinaCombinatoria PORT map(
        i=>romtocomb, o=>combtomem);
        
    mem : entity work.memory GENERIC MAP(
        N=>3, M=>8)
        port map(
            rst=>reset, read=>mem_read, write=>mem_write, clk=>clk, input=>combtomem, address=>mem_address, output =>output);
end Structural;
