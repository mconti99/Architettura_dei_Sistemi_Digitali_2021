library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ff_t is port(
        T : in std_logic;
        rst : in std_logic;
        clk: in std_logic;
        q: out std_logic
    );
end ff_t;

architecture Behavioral of ff_t is
signal q_tmp : std_logic;
begin
    ff_proc : process(clk) begin
    if(rising_edge(clk)) then
        if(rst = '1') then
            q_tmp <= '0';
        elsif(T='1') then
            q_tmp <= not q_tmp;
        end if;
    end if;
    end process;

    q <= q_tmp;
end Behavioral;