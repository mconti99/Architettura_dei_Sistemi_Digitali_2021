----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2021 17:05:16
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit is
    port(
    read : in std_logic;
    clk : in std_logic;
    reset : in std_logic;
    counter_value : in std_logic_vector(2 downto 0);
    visual_b : in std_logic;
    counter_inc : out std_logic;
    rom_enable : out std_logic;
    system_reset : out std_logic;--uscita che vale come reset per la parte operativa
    mem_write : out std_logic;
    mem_read : out std_logic);
end ControlUnit;

architecture Behavioral of ControlUnit is
type stato is (START, LOAD, MEM, INC, VISUAL);
signal state : stato := START;
begin
    cu_proc_state: process(clk) begin 
    if(rising_edge(clk)) then
        if(reset='1') then state <= START;
        elsif(state=START) then
            if(read='1') then state <= LOAD;
            elsif(visual_b='1') then state <= VISUAL;
            end if;
        elsif(state=LOAD) then state <= MEM;
        elsif(state=VISUAL and visual_b='1') then state<=START;
        elsif(state=MEM) then state <= INC;
        elsif(state=INC) then
            if(counter_value="111") then state <= START;
            else state <= LOAD;
            end if;
        end if;
    end if;
    end process;
    
    cu_proc_out : process(state) begin
        counter_inc <= '0';
        rom_enable <= '0';
        system_reset <= '0';
        mem_write <='0';
        mem_read <='0';
    if(state=LOAD) then
        rom_enable <= '1';
    elsif(state=MEM) then
        mem_write <='1';
    elsif(state=INC) then
        counter_inc <= '1';
    elsif(state=VISUAL) then
        mem_read <= '1';
    end if;
    end process;
end Behavioral;
