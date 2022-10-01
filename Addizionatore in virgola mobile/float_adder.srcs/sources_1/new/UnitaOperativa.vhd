library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity UnitaOperativa is
    port(
        clk : in std_logic;
        op1, op2 : in std_logic_vector(31 downto 0);
        
        final_shift : out std_logic_vector(24 downto 0);
        N_shifts : out std_logic_vector(7 downto 0);
        
        reg_reset : in std_logic;
        write_ops, write_n_shifts : in std_logic;
        load_mantissa, shift_op : in std_logic;
        shift_final, lr_final, final_shift_load, mux_correction: in std_logic;
        
   
        res : out std_logic_vector(31 downto 0)
    );
end UnitaOperativa;

architecture Structural of UnitaOperativa is

signal regA, regB : std_logic_vector(31 downto 0);
signal expA, expB, diff_exp, abs_diff_exp : std_logic_vector(8 downto 0); --8 bit + segno
signal mantissaA, mantissaB : std_logic_vector(22 downto 0);
signal signA, signB : std_logic;
signal sign_mantissaA, sign_mantissaB : std_logic_vector(23 downto 0);
signal M : std_logic;

signal minMantissa, maxMantissa : std_logic_vector(23 downto 0);

signal exp_max_mux, exp_max : std_logic_vector(7 downto 0);

signal muxMintoreg, muxMaxtoreg : std_logic_vector(24 downto 0);

signal shift_reg_min_out, reg_max_out : std_logic_vector(24 downto 0);

signal add1, add2, res_addizione, mantissa_da_normalizzare : std_logic_vector(25 downto 0);

signal mantissa_finale : std_logic_vector(24 downto 0);

signal mux_correct_out, adder_exp_out : std_logic_vector(7 downto 0);

signal not_lr : std_logic;

begin
    expA <= '0' & regA(30 downto 23);
    expB <= '0' & regB(30 downto 23);
    
    signA <= regA(31);
    signB <= regB(31);
    
    mantissaA <= regA(22 downto 0);
    mantissaB <= regB(22 downto 0);
    
    sign_mantissaA <= signA & mantissaA;
    sign_mantissaB <= signB & mantissaB;
    
    A : entity work.registro generic map(
        N => 32
    ) port map (
        clk=>clk, rst => reg_reset, write => write_ops, data_in => op1, data_out => regA
    );
    B : entity work.registro generic map(
        N => 32
    ) port map (
        clk=>clk, rst => reg_reset, write => write_ops, data_in => op2, data_out => regB
    );
    
    sub_exp : entity work.ripple_carry_adder generic map(
        N=>9 
    ) port map (
            A=>expA, B=>expB, res=>diff_exp, sub=>'1' 
    );
    
    abs_sub_exp : entity work.abs_value generic map(
        N=>9
    ) port map  (
        X=>diff_exp, Y => abs_diff_exp  
    );
    
    M <= diff_exp(8);
    
    n_shifts_reg : entity work.registro generic map(
        N=>8
    ) port map (
        clk=>clk, rst=> reg_reset, data_in=>abs_diff_exp(7 downto 0), write=>write_n_shifts, data_out=>N_shifts
    );
    
    mux_exp_max : entity work.mux generic map(
        N=>8
    ) port map(
        a=>expA(7 downto 0), b=>expB(7 downto 0), s=>M, out_d=>exp_max_mux
    );
    
    mux_correct_exp : entity work.mux generic map(
        N=>8
    ) port map (
       a=>exp_max_mux, b=>adder_exp_out, s=>mux_correction, out_d=> mux_correct_out
    );
    
    not_lr <= not lr_final;
    
    adder_correct_exp : entity work.ripple_carry_adder generic map(
        N=>8
    ) port map (
        a=>exp_max, b=>"00000001", sub => not_lr, res => adder_exp_out
    );
    
    exp_res : entity work.registro generic map(
        N=>8
    ) port map (
        clk=>clk, rst=>reg_reset, write=>write_n_shifts, data_in=>mux_correct_out, data_out=>exp_max
    );
     
    
    mux_mantissa_min : entity work.mux generic map(
        N=>24 --dim mantissa + bit segno
    ) port map (
        a=>sign_mantissaB, b=>sign_mantissaA, s=>M,  out_d =>minMantissa
    );
    
    mux_mantissa_max : entity work.mux generic map(
        N=>24 --dim mantissa + bit segno
    ) port map (
        a=>sign_mantissaA, b=>sign_mantissaB, s=>M,  out_d =>maxMantissa
    );
    
    muxmaxtoreg <= "01" & maxMantissa(22 downto 0);
    muxmintoreg <= "01" & minMantissa(22 downto 0);
    
    shift_register_min : entity work.shift_register generic map(
        N => 25
    ) port map (
        clk=>clk, shift=>shift_op, lr=>'1', reset=>reg_reset, load=>load_mantissa, 
        serial_in => '0', parallel_in => muxmintoreg, parallel_out => shift_reg_min_out
    );
    
    reg_max : entity work.registro generic map(
        N =>25
    ) port map (
        clk=>clk, rst=>reg_reset, write=>load_mantissa, data_in => muxmaxtoreg, data_out=>reg_max_out
    );
    
    convMin : entity work.converter generic map(
        N => 25
    ) port map (
        X=>shift_reg_min_out, sign => minMantissa(23), Y=>add1
    );
    
    convMax : entity work.converter generic map(
        N => 25
    ) port map (
        X=>reg_max_out, sign => maxMantissa(23), Y=>add2
    );
    
    add_final : entity work.ripple_carry_adder generic map(
        N => 26
    ) port map(
        A => add1, B => add2, sub => '0', res=>res_addizione
    );
    
    abs_res : entity work.abs_value generic map(
        N=>26
    ) port map (
        X=>res_addizione, Y=>mantissa_da_normalizzare
    );
    
    final_shift_reg : entity work.shift_register generic map(
        N=>25
    ) port map (
        clk=>clk, shift=>shift_final, lr=>lr_final, reset=>reg_reset, load=>final_shift_load,
        parallel_in => mantissa_da_normalizzare(24 downto 0), serial_in => '0', parallel_out => mantissa_finale
    );
    
    res <= res_addizione(25) & exp_max & mantissa_finale(22 downto 0);
    
    final_shift <= mantissa_finale;
end Structural;
