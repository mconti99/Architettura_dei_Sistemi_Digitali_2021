library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity shift_register is
    generic(
        N : integer := 32
    );
    port(
        clk : in std_logic;
        shift : in std_logic;
        lr : in std_logic;
        reset : in std_logic;
        load : in std_logic;
        
        serial_in : in std_logic;
        parallel_in : in std_logic_vector(N-1 downto 0);
        
        serial_out : out std_logic;
        parallel_out : out std_logic_vector(N-1 downto 0)
    );
end shift_register;

architecture Behavioral of shift_register is

signal state : std_logic_vector(N-1 downto 0);

begin
    parallel_out <= state;
    serial_out <= state(0);
    
    process(clk) begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                state <= (others => '0');
            elsif(shift = '1' and lr = '0') then
                state <= state(N-2 downto 0) & serial_in ;
            elsif(shift = '1' and lr = '1') then
                state <= serial_in & state(N-1 downto 1);
            elsif(load = '1') then
                state <= parallel_in;
            else
                state <= state;
            end if;
        end if;
    end process;

end Behavioral;
