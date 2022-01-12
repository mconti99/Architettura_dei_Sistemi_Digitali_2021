library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ff_d is
    port(
        clk : in std_logic;
        
        rst : in std_logic;
        enable : in std_logic;
        
        d : in std_logic;
        u : out std_logic
    );
end ff_d;

architecture Behavioral of ff_d is

signal q : std_logic;

begin
    u <= q;
    process(clk) begin
        if(rising_edge(clk) and enable = '1') then
            if(rst = '1') then 
                q <= '0';
            else
                q <= d;
            end if;
        end if;
    end process;

end Behavioral;
