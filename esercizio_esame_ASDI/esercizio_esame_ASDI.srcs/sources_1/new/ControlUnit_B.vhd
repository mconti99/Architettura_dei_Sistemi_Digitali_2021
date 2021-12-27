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
    conteggio : in std_logic_vector(2 downto 0);    
    reset : in std_logic;
    
    reset_system : out std_logic;
    inc_cont_mem : out std_logic;
    mem_write : out std_logic;
    buffer1_write : out std_logic;
    buffer2_write : out std_logic;
    inc_cont_str : out std_logic;
  
    ack : out std_logic);
end ControlUnit_B;

architecture Behavioral of ControlUnit_B is
type stato is (IDLE, PRELIEVO1, PRELIEVO2, CALC, INCR_MEM, INCR_STR, ACK_OUT, RESET_DATAPATH);
signal state : stato := IDLE;
begin
cu_state : process(clk) begin
    if(rising_edge(clk)) then
        if(reset='1') then state<=RESET_DATAPATH;
        else
            if(state=IDLE and r='1' and conteggio(0)='0') THEN state<=PRELIEVO1;
            elsif(state=PRELIEVO1) then state<= INCR_STR;
            elsif(state=INCR_STR) then state<=ACK_OUT;
            elsif(state=ACK_OUT and r='0') then state <= IDLE;
            elsif(state=IDLE and r='1' and conteggio(0)='1') then state <= PRELIEVO2;
            elsif(state=PRELIEVO2) then state <= CALC;
            elsif(state=CALC) then state <= INCR_MEM;
            elsif(state=INCR_MEM) then state <= INCR_STR;
            elsif(state=RESET_DATAPATH) then state <= IDLE;
            end if;
        end if;
    end if;
end process;

cu_out : process(state) begin
    inc_cont_mem <= '0';
    mem_write <='0';
    buffer1_write <='0';
    buffer2_write <='0';
    inc_cont_str <= '0';
    ack <= '0';
    
    case state is  
        when IDLE =>
            inc_cont_mem <= '0';
            mem_write <='0';
            buffer1_write <='0';
            buffer2_write <='0';
            inc_cont_str <= '0';
            ack <= '0';  
            reset_system<='0';
        when PRELIEVO1 =>
            buffer1_write <= '1';
        when PRELIEVO2 =>
            buffer2_write <= '1';      
        when CALC=>
            mem_write <= '1'; 
        when INCR_MEM=> 
            inc_cont_mem <= '1';
        when INCR_STR=>
            inc_cont_str <= '1';
        when ACK_OUT=> 
            ack <= '1';
        when RESET_DATAPATH =>
            reset_system<='1';
     end case;
end process;
end Behavioral;
