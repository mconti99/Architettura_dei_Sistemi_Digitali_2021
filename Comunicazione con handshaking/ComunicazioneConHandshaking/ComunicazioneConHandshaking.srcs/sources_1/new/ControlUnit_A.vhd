----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2021 22:52:46
-- Design Name: 
-- Module Name: ControlUnit_A - Behavioral
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
entity ControlUnit_A is
    port(
    clk : in std_logic;
    start : in std_logic;
    ack : in std_logic;
    r : out std_logic;
    conteggio : in std_logic_vector(2 downto 0);
    inc_register : out std_logic;
    mem_read : out std_logic;
    buffer_write : out std_logic;
    reset_datapath : out std_logic);
end ControlUnit_A;

architecture Behavioral of ControlUnit_A is
type stato is (IDLE, READING, LOAD, REQUEST, WAIT_ACK, COUNT);
signal state : stato := IDLE;
 
begin
cu_state : process(clk) begin
    if(falling_edge(clk)) then
        if(state=IDLE and start='1') then state<=READING;
        elsif(state= READING) then state <=LOAD;
        elsif(state=LOAD) then state<= REQUEST;
        elsif(state=REQUEST and ack='1') then state<=WAIT_ACK;
        elsif(state=WAIT_ACK and ack='0') then state <= COUNT;
        elsif(state=COUNT and conv_integer(conteggio)=0) then state<=IDLE;
        elsif(state=COUNT and conv_integer(conteggio)>0) then state<= READING;
        end if;
    end if;
end process;

cu_out : process(state) begin
    case state is
        when IDLE =>
            r <= '0';
            inc_register <= '0';
            buffer_write <= '0';
            reset_datapath <= '1';
            mem_read <= '0';
        when READING =>
            r <= '0';
            inc_register <= '0';
            buffer_write <= '0';
            reset_datapath <= '0'; 
            mem_read <= '1';        
        when LOAD =>
            r <= '0';
            inc_register <= '0';
            buffer_write <= '1';
            reset_datapath <= '0';
            mem_read <= '0';            
        when REQUEST =>
            r <= '1';
            inc_register <= '0';
            buffer_write <= '0';
            reset_datapath <= '0';
            mem_read <= '0';            
        when WAIT_ACK =>
            r <= '0';
            inc_register <= '0';
            buffer_write <= '0';
            reset_datapath <= '0';
            mem_read <= '0';
        when COUNT =>
            r <= '0';
            inc_register <= '1';
            buffer_write <= '0';
            reset_datapath <= '0';
            mem_read <= '0';
    end case;
end process;
    

end Behavioral;
