library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;

entity ControlUnit is port(
     start_b : in std_logic;
     
     clk : in std_logic;
     N_shifts : in std_logic_vector(7 downto 0);
     final_shift : in std_logic_vector(24 downto 0);
     
     reg_reset : out std_logic;
     write_ops, write_n_shifts : out std_logic;
     load_mantissa, shift_op : out std_logic;
     shift_final, lr_final, final_shift_load, mux_correction: out std_logic);
end ControlUnit;

architecture Behavioral of ControlUnit is
type stato is (IDLE, START, SUB_EXP, STORE_EXP, SHIFT, CALC_MANTISSA, STORE_MANTISSA, NORMALIZE_1, NORMALIZE_2, CLEAR);
signal stato_corrente : stato := IDLE;
signal shift_effettuati : std_logic_vector(7 downto 0):= "00000000";
begin

proc_state : process(clk) begin
    if(rising_edge(clk)) then
        if(stato_corrente=IDLE and start_b='1') then stato_corrente <= CLEAR;
        elsif(stato_corrente=CLEAR) then stato_corrente <= START;
        elsif(stato_corrente=START) then stato_corrente <= SUB_EXP;
        elsif(stato_corrente=SUB_EXP) then stato_corrente <= STORE_EXP;
        elsif(stato_corrente=STORE_EXP) then 
            if(N_shifts=x"00") then stato_corrente <= CALC_MANTISSA;
            else stato_corrente <= SHIFT;
            end if;
        elsif(stato_corrente=SHIFT and shift_effettuati=N_shifts-1) then 
            stato_corrente <= CALC_MANTISSA;
            shift_effettuati <= (others=>'0');
        elsif(stato_corrente=SHIFT) then 
            stato_corrente <= SHIFT;
            shift_effettuati<=shift_effettuati+1;
        elsif(stato_corrente=CALC_MANTISSA) then
            stato_corrente<=STORE_MANTISSA;
        elsif(stato_corrente=STORE_MANTISSA) then
            if(final_shift=x"000000"&"0") then stato_corrente <= IDLE;
            elsif(final_shift(24)='1') then stato_corrente <= NORMALIZE_1;
            elsif(final_shift(24)='0' and final_shift(23)='1') then stato_corrente <= IDLE;
            elsif(final_shift(24)='0' and final_shift(23)='0') then stato_corrente <= NORMALIZE_2;
            end if;
        elsif(stato_corrente = NORMALIZE_1) then stato_corrente <= IDLE;
        elsif(stato_corrente = NORMALIZE_2) then
            if(final_shift(22)='0') then stato_corrente <= NORMALIZE_2;
            else stato_corrente <= IDLE;
            end if;
        end if;
    end if;
end process;

out_proc : process(stato_corrente) begin
    reg_reset <= '0';
    write_ops <= '0';
    write_n_shifts <= '0';
    load_mantissa <= '0'; 
    shift_op <= '0';
    shift_final <= '0';
    lr_final <= '0';
    final_shift_load <= '0'; 
    mux_correction <= '0';
    
    if(stato_corrente=START) then
        write_ops <= '1';
    elsif(stato_corrente=CLEAR) then
        reg_reset <= '1';
    elsif(stato_corrente=SUB_EXP) then
        write_n_shifts <= '1';
        load_mantissa <= '1';
    elsif(stato_corrente=SHIFT) then
        shift_op <= '1';
    elsif(stato_corrente=CALC_MANTISSA) then
        final_shift_load <= '1';
    elsif(stato_corrente=NORMALIZE_1) then
        lr_final <= '1';
        write_n_shifts<='1';
        shift_final <= '1';
        mux_correction <= '1';
    elsif(stato_corrente=NORMALIZE_2) then
        mux_correction <= '1';
        write_n_shifts <= '1';
        shift_final <= '1';
    end if;
end process;
end Behavioral;
