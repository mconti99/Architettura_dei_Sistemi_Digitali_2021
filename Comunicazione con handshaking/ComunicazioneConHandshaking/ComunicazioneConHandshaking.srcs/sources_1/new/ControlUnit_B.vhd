----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2021 10:53:50
-- Design Name: 
-- Module Name: ControlUnit_B - Behavioral
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

entity ControlUnit_B is port(
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
end ControlUnit_B;

architecture Behavioral of ControlUnit_B is
type stato is (IDLE, PRELIEVO, CALC, SAVE, INCR, ACK_OUT, VISUAL);
signal state : stato := IDLE;
begin
cu_state : process(clk) begin
    if(falling_edge(clk)) then
        if(state=IDLE and r='1') THEN state<=PRELIEVO;
        elsif(state=IDLE and visual_b='1') then state <= VISUAL;
        elsif(state=VISUAL and visual_b='1') then state <= IDLE;
        elsif(state=PRELIEVO) then state <= CALC;
        elsif(state=CALC) then state <= SAVE;
        elsif(state=SAVE) then state <= INCR;
        elsif(state=INCR) THEN state <= ack_out;
        elsif(state=ACK_OUT and r='0') then state <= IDLE;
        end if;
    end if;
end process;

cu_out : process(state) begin
    case state is
        when IDLE =>
            inc_register <= '0';
            reset_datapath <= '0';
            buffer_write <= '0';
            msg_read <= '0';
            mem_read <= '0';
            mem_write <= '0';
            ack<='0';  
            enable_visore <='0';
            switch_mode <='0'; 
        when VISUAL =>
            inc_register <= '0';
            reset_datapath <= '0';
            buffer_write <= '0';
            msg_read <= '0';
            mem_read <= '1';
            mem_write <= '0';
            ack<='0'; 
            enable_visore <='1';
            switch_mode <='1';        
        when PRELIEVO =>
            inc_register <= '0';
            reset_datapath <= '0';
            buffer_write <= '0';
            msg_read <= '1';
            mem_read <= '1';
            mem_write <= '0';
            ack<='0';  
            enable_visore <='0';
            switch_mode <='0';
        when CALC =>
            inc_register <= '0';
            reset_datapath <= '0';
            buffer_write <= '1';--scrivo il risultato nel tampone
            msg_read <= '0';
            mem_read <= '0';
            mem_write <= '0';
            ack<='0';
            enable_visore <='0';
            switch_mode <='0';      
        when SAVE=>
            inc_register <= '0';
            reset_datapath <= '0';
            buffer_write <= '0';
            msg_read <= '0';
            mem_read <= '0';
            mem_write <= '1'; 
            ack<='0';
            enable_visore <='0';
            switch_mode <='0';  
        when INCR=> 
            inc_register <= '1';
            reset_datapath <= '0';
            buffer_write <= '0';
            msg_read <= '0';
            mem_read <= '0';
            mem_write <= '0';  
            ack<='0';
            enable_visore <='0';
            switch_mode <='0';  
        when ACK_OUT=> 
            inc_register <= '0';
            reset_datapath <= '0';
            buffer_write <= '0';
            msg_read <= '0';
            mem_read <= '0';
            mem_write <= '0'; 
            ack <= '1';
            enable_visore <='0';
            switch_mode <='0';
     end case;
end process;
end Behavioral;
