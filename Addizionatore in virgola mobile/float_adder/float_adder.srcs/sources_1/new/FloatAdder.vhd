library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity FloatAdder is port(
    clk : in std_logic;
    start_b : in std_logic;
    op1, op2 : in std_logic_vector(31 downto 0);
    
    res : out std_logic_vector(31 downto 0)
);
end FloatAdder;

architecture Structural of FloatAdder is

signal final_shift :  std_logic_vector(24 downto 0);
signal N_shifts :  std_logic_vector(7 downto 0);
signal reg_reset :  std_logic;
signal write_ops : std_logic;
signal write_n_shifts : std_logic;
signal load_mantissa : std_logic;
signal shift_op : std_logic;
signal shift_final : std_logic;
signal lr_final : std_logic; 
signal final_shift_load: std_logic; 
signal mux_correction: std_logic;

begin

uo : entity work.unitaoperativa port map(
    final_shift=>final_shift, N_shifts=>N_shifts, reg_reset=>reg_reset, write_ops=>write_ops, write_n_shifts=>write_n_shifts, 
    load_mantissa=>load_mantissa, shift_op=>shift_op, shift_final=>shift_final, lr_final=>lr_final, final_shift_load=>final_shift_load,
    mux_correction=>mux_correction, clk=>clk, op1=>op1, op2=>op2, res=>res);

uc: entity work.controlunit port map(
    final_shift=>final_shift, N_shifts=>N_shifts, reg_reset=>reg_reset, write_ops=>write_ops, write_n_shifts=>write_n_shifts, 
    load_mantissa=>load_mantissa, shift_op=>shift_op, shift_final=>shift_final, lr_final=>lr_final, final_shift_load=>final_shift_load,
    mux_correction=>mux_correction, clk=>clk, start_b=>start_b);


end Structural;
