library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity variable_shift_register_TB is
end variable_shift_register_TB;

architecture Behavioral of variable_shift_register_TB is
component variable_shift_register is
    generic(
        N : integer := 16
    );
    port(
        clk : in std_logic;
        
        rst : in std_logic;
        enable : in std_logic;
        shifts : in std_logic_vector(1 downto 0);
        parallel_load : in std_logic;
        parallel_input : in std_logic_vector(N-1 downto 0);
        
        state : out std_logic_vector(N-1 downto 0)
    );
end component;

signal clk : std_logic;
signal rst : std_logic;
signal enable : std_logic;
signal shifts : std_logic_vector(1 downto 0);
signal state : std_logic_vector(8-1 downto 0);
signal parallel_load : std_logic;
signal parallel_input : std_logic_vector(8-1 downto 0);

begin
     clk_prc : process begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
     end process;
     
     ins_prc : process begin
        enable <= '1';
        rst <= '0';
        wait for 5 ns;
        parallel_input <= x"A0";
        parallel_load <= '1';
        wait for 51 ns;
        parallel_load <= '0';
        shifts <= "00";
        wait for 100 ns;
        shifts <= "10";
        wait for 100 ns;
        shifts <= "01";
        wait;
     end process;
     
     uut : variable_shift_register generic map(
        N => 8
     ) port map (
        clk => clk, rst => rst, enable => enable, shifts => shifts, state => state, parallel_input => parallel_input, parallel_load => parallel_load
     );
     
end Behavioral;
