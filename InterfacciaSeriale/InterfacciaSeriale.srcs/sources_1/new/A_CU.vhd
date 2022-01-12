library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity A_CU is
    port(
        clk : in std_logic;
        start : in std_logic;
        reset : in std_logic;
        TBE : in std_logic;
        
        inc_register : out std_logic;
        WR : out std_logic;
        sys_rst : out std_logic
   );
end A_CU;

architecture Behavioral of A_CU is

type state is (IDLE, WRITE, WAIT_COM, INC);
signal stato : state := IDLE; 

begin
    state_prc : process(clk) begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                stato <= IDLE;
            elsif(stato = IDLE and start = '1') then
                stato <= WRITE;
            elsif(stato = WRITE and TBE = '0') then
                stato <= WAIT_COM;
            elsif(stato = WAIT_COM and TBE = '1') then
                stato <= INC;
            elsif(stato = INC) then
                stato<=IDLE;
            end if;
        end if;
    end process;
    
    out_prc : process(stato) begin
        WR <= '0';
        sys_rst <= '0';
        inc_register <= '0';
        if(stato = IDLE) then
            sys_rst <= '1';
        elsif(stato = WRITE) then
            WR <= '1';
        elsif(stato=INC) then
            inc_register <= '1';
        end if;
    end process;
    
end Behavioral;