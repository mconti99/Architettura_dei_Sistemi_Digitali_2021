library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity dp_TB is
end dp_TB;

architecture Behavioral of dp_TB is

signal clk : std_logic;
signal op1, op2 : std_logic_vector(31 downto 0);
signal reg_reset : std_logic;
signal write_ops, write_n_shifts : std_logic;
signal load_mantissa, shift_op : std_logic;
signal shift_final, lr_final, final_shift_load: std_logic;
signal res : std_logic_vector(31 downto 0);
signal mux_correction : std_logic;

begin
    uut : entity work.unitaoperativa port map(
        clk=>clk,op1=>op1,op2=>op2,reg_reset=>reg_reset,
        write_ops=>write_ops,write_n_shifts=>write_n_shifts,
        load_mantissa=>load_mantissa,
        shift_op=>shift_op,shift_final=>shift_final
        , lr_final=>lr_final, final_shift_load=>final_shift_load
        ,res =>res, mux_correction=>mux_correction
    );
    
    clk_proc : process begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
     end process;
     
     inp_proc : process begin
        wait for 3 ns;
        mux_correction <= '0';
        reg_reset <= '1';
        wait for 20 ns;
        reg_reset <= '0';
        write_ops <= '1';
        op1 <= '0' & "10000001" & "11000001010001111010111"; --7.02
        op2 <= '1' & "10000001" & "11000000101000111101011"; -- -7.01
        wait for 20 ns;
        write_ops <= '0';
        write_n_shifts <= '1';
        load_mantissa <= '1';
        wait for 20 ns;
        load_mantissa <= '0';
        write_n_shifts <= '0';
   --     shift_op <= '1';
        wait for 10 ns;
        shift_op <= '0';
        final_shift_load <= '1';
        wait for 10 ns;
        final_shift_load <= '0';
        
        
        wait for 10 ns;
        write_n_shifts <= '0';
        mux_correction <= '1';
        lr_final <= '0';
        shift_final <= '1';
        wait for 10 ns;
        write_n_shifts <= '1';
        shift_final <= '0';
        
        wait for 10 ns;
        write_n_shifts <= '0';
        mux_correction <= '1';
        lr_final <= '0';
        shift_final <= '1';
        wait for 10 ns;
        write_n_shifts <= '1';
        shift_final <= '0';
        
        wait for 10 ns;
        write_n_shifts <= '0';
        mux_correction <= '1';
        lr_final <= '0';
        shift_final <= '1';
        wait for 10 ns;
        write_n_shifts <= '1';
        shift_final <= '0';
        
        wait for 10 ns;
        write_n_shifts <= '0';
        mux_correction <= '1';
        lr_final <= '0';
        shift_final <= '1';
        wait for 10 ns;
        write_n_shifts <= '1';
        shift_final <= '0';
        
        wait for 10 ns;
        write_n_shifts <= '0';
        mux_correction <= '1';
        lr_final <= '0';
        shift_final <= '1';
        wait for 10 ns;
        write_n_shifts <= '1';
        shift_final <= '0';
        
        wait for 10 ns;
        write_n_shifts <= '0';
        mux_correction <= '1';
        lr_final <= '0';
        shift_final <= '1';
        wait for 10 ns;
        write_n_shifts <= '1';
        shift_final <= '0';
        
        wait for 10 ns;
        write_n_shifts <= '0';
        mux_correction <= '1';
        lr_final <= '0';
        shift_final <= '1';
        wait for 10 ns;
        write_n_shifts <= '1';
        shift_final <= '0';
        
        wait for 10 ns;
        write_n_shifts <= '0';
        mux_correction <= '1';
        lr_final <= '0';
        shift_final <= '1';
        wait for 10 ns;
        write_n_shifts <= '1';
        shift_final <= '0';
        
        wait for 10 ns;
        write_n_shifts <= '0';
        mux_correction <= '1';
        lr_final <= '0';
        shift_final <= '1';
        wait for 10 ns;
        write_n_shifts <= '1';
        shift_final <= '0';
        wait for 10 ns;
        write_n_shifts <= '0';

        wait;
     end process;
end Behavioral;
