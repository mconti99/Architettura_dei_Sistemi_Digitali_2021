library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity variable_shift_register is
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
end variable_shift_register;

architecture Structural of variable_shift_register is

component Mux4_1 is
    Port(
        X : in STD_LOGIC_VECTOR(3 downto 0);
        S : in STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC
       );
end component;

component Mux2_1 is
    Port(
        X : in STD_LOGIC_VECTOR(1 downto 0);
        S : in STD_LOGIC;
        Y : out STD_LOGIC
       );
end component;

component ff_d is
    port(
        clk : in std_logic;
        
        rst : in std_logic;
        enable : in std_logic;
        
        d : in std_logic;
        u : out std_logic
    );
end component;

signal muxtoff : std_logic_vector(N-1 downto 0);
signal fftomux : std_logic_vector(N-1 downto 0);
signal muxtomux : std_logic_vector(N-1 downto 0);

begin
    
    state <= fftomux;
    
    FFs : for i in 0 to N-1 generate
        FF : ff_d port map(
            clk => clk, rst => rst, enable => enable, d=> muxtoff(i), u =>fftomux(i)
        );
        
        MUXs : mux2_1 port map(
            S => parallel_load, X(0) => muxtomux(i), X(1) => parallel_input(i), Y =>muxtoff(i)
        );
        
        MUX : mux4_1 port map(
            S => shifts, Y => muxtomux(i), X(0) => fftomux((i-1) mod N), X(1) => fftomux((i-2) mod N), X(2) => fftomux((i+1) mod N), X(3) => fftomux((i+2) mod N)
        );
        
    end generate;   
    
end Structural;
