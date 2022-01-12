library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register_TB is
end shift_register_TB;

architecture Behavioral of shift_register_TB is

component shift_register is
    generic(
        N : integer := 16
    );
    port(
        clk : in std_logic;
        enable : in std_logic;
        rst : in std_logic;
        
        parallel_in : in std_logic_vector(N-1 downto 0);
        parallel_load : in std_logic;
        
        shifts : in std_logic_vector(3 downto 0);
        lr : in std_logic; --- 0 shift a dx 1 shift a sx
        q : out std_logic_vector(N-1 downto 0)
    );
end component;

signal clk : std_logic;
signal lr : std_logic;
signal shifts : std_logic_vector(3 downto 0);
signal rst : std_logic;
signal enable : std_logic;
signal parallel_load : std_logic;
signal parallel_in : std_logic_vector(15 downto 0);
signal q : std_logic_vector(15 downto 0);

begin
    clk_tb : process begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;
    
    ins_tb : process begin
        enable <= '1';
        rst <= '0';
        shifts <= x"1";
        parallel_load <= '1';
        parallel_in <= x"0002";
        wait for 15 ns;
        parallel_load <= '0';
        wait for 20 ns;
        lr <= '0';
        shifts <= x"1";
        wait for 20 ns;
        shifts <= x"3";
        wait for 20 ns;
        shifts <= x"3";
        wait for 20 ns;
        shifts <= x"1";
        wait for 20 ns;
        lr <= '1';
        wait for 20 ns;
        shifts <= x"3";
        wait for 30 ns;
        rst <= '1';
        wait;
    end process;
    
    uut : shift_register generic map(
        N => 16
    ) port map(
        clk => clk, parallel_in => parallel_in, parallel_load => parallel_load, enable => enable, lr => lr, shifts => shifts, rst => rst, q=>q
    );
    
end Behavioral;
