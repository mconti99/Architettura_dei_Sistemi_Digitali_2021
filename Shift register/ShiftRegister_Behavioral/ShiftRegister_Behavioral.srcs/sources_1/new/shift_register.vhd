library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity shift_register is
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
        lr : in std_logic; --- 0 shift a sx 1 shift a dx
        q : out std_logic_vector(N-1 downto 0)
    );
end shift_register;

architecture Behavioral of shift_register is

signal state : std_logic_vector(N-1 downto 0);

begin
    q <= state;   
    
    process(clk) begin
        if(rising_edge(clk) and enable = '1') then
            if(rst = '1') then
                state <= (others => '0');
            elsif(parallel_load = '1') then
                state <= parallel_in;
            elsif(lr = '0') then                
                state(N-1 downto conv_integer(shifts)) <= state(N-1- conv_integer(shifts) downto 0);
                state(conv_integer(shifts) - 1 downto 0) <= state(N-1 downto N - conv_integer(shifts));
            elsif(lr = '1') then
                state(N-1-conv_integer(shifts) downto 0) <= state(N-1 downto conv_integer(shifts));
                state(N-1 downto N-conv_integer(shifts)) <= state(conv_integer(shifts)-1 downto 0);
            end if;
        end if;
    end process;
end Behavioral;