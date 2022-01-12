library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity B_CU is
    port(
        clk : in std_logic;
        RDA : in std_logic;
        rst : in std_logic;
        start : in std_logic;
        
        rst_usart : out std_logic;       
        RD : out std_logic;
        mem_in : out std_logic;
        mem_read : out std_logic;
        inc_register : out std_logic
    );
end B_CU;

architecture Behavioral of B_CU is

type state is (IDLE, SAVE_DATA, VISUAL, LOAD, INC);
signal stato : state:= IDLE;

begin
    state_prc : process(clk) begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                stato <= IDLE;
            elsif(stato = IDLE and RDA = '1') then
                stato <= SAVE_DATA;
            elsif(stato = SAVE_DATA) then
                stato <= LOAD;
            elsif(stato= LOAD) then
                stato <= VISUAL;
            elsif(stato = VISUAL and start = '1') then
                stato <= INC;   
            elsif(stato=INC) then
                stato <= IDLE;
            end if;
        end if;
    end process;
    
    out_prc : process(stato) begin
        RD <= '0';
        mem_in <= '0';
        inc_register <= '0';
        rst_usart <= '0'; 
        mem_read <= '0';
        if(stato = IDLE) then
            RD <= '0';
        elsif(stato = SAVE_DATA) then
            mem_in <= '1';
        elsif(stato=VISUAL) then
            rst_usart <= '1';
            mem_read <= '1';
        elsif(stato=INC) then
            inc_register <='1';
        end if;
    end process;

end Behavioral;
