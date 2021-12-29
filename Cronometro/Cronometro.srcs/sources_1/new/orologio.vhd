library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;

entity orologio is
    port(
        clk, rst, load, count : in std_logic;
        sec_in : in std_logic_vector(5 downto 0);
        min_in : in std_logic_vector(5 downto 0);
        hour_in : in std_logic_vector(4 downto 0);
        
        sec : out std_logic_vector(5 downto 0);
        min : out std_logic_vector(5 downto 0);
        hour : out std_logic_vector(4 downto 0)
    );
end orologio;

architecture Structural of orologio is
    component counter is
        generic(
            M : integer := 8
        );
        port(
            clk, rst, count, load : in std_logic;
            parallel_input : in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
            clk_out : out std_logic;
            Y : out std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0)
        );
    end component;
    
    signal u : std_logic_vector(2 downto 0);
    signal enabs : std_logic_vector(1 downto 0);
    
begin
    
    enabs(0) <= u(0) and u(1);
    enabs(1) <= u(0) and u(1) and u(2);
    
    bdt : counter generic map(
       M => 100000000--2 per il tb
    ) port map(
        clk => clk, rst => rst, count => count, load => '0', parallel_input => (others => '0'), clk_out => u(0) 
    );
    
    secs : counter generic map(
        M => 60
    ) port map(
        clk => clk, rst => rst, count => u(0), load => load, parallel_input => sec_in, Y => sec, clk_out => u(1)
    );
    
    mins : counter generic map(
        M => 60
    ) port map(
        clk => clk, rst => rst, count => enabs(0), load => load, parallel_input => min_in, Y => min, clk_out => u(2)
    );
    
    hours : counter generic map(
        M => 24
    ) port map(
        clk => clk, rst => rst, count => enabs(1), load => load, parallel_input => hour_in, Y => hour
    );

end Structural;
