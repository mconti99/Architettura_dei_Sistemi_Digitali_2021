library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;
entity ControlUnit is
    port(
    clk : in std_logic;

    -- Input utente
    start_b : in std_logic;
    rst_b: in std_logic;
    load_b : in std_logic;
    mem_b : in std_logic;
    visual_b : in std_logic;

    -- Stato Datapath
    n_intertempi : in std_logic_vector(1 downto 0); --uscita del contatore degli intertempi

    -- Controllo
    mem_write : out std_logic; 
    mem_read : out std_logic;
    clock_load : out std_logic;
    clock_rst : out std_logic;
    incrementa_intertempi : out std_logic; --abilita il contatore degli intertempi 
    counting : out std_logic; --ingresso del ff che memorizza lo stato (del cronometro)
    display_mode : out std_logic; --selezione multiplexer del visore
    mem_mode : out std_logic; --selezione multiplexer della memor
    addr : out std_logic_vector(1 downto 0)

    );
end ControlUnit;

architecture Behavioral of ControlUnit is
type stato is (IDLE, START, MEM, INCR, RESET, LOAD, VISUAL);
signal stato_corrente : stato := IDLE;
signal IndiceVisualizzato : std_logic_vector(1 downto 0) := "00";
begin
state_prc : process(clk) begin
    if(falling_edge(clk)) then
        if(stato_corrente=IDLE) then
            if(start_b='1') then stato_corrente <= START;
            elsif(rst_b='1') then stato_corrente <= RESET;
            elsif(mem_b='1') then stato_corrente <= MEM;
            elsif(load_b='1') then stato_corrente <= LOAD;
            elsif(visual_b='1') then stato_corrente <= VISUAL;
            end if;
        elsif(stato_corrente=START) then stato_corrente <= IDLE;
        elsif(stato_corrente=RESET) then stato_corrente <= IDLE;
        elsif(stato_corrente=LOAD) then stato_corrente <= IDLE;
        elsif(stato_corrente=MEM) then stato_corrente <= INCR;
        elsif(stato_corrente=INCR) then stato_corrente <= IDLE;
        elsif(stato_corrente=VISUAL and visual_b='1') then 
            if(IndiceVisualizzato="11") then
                IndiceVisualizzato<="00";
                stato_corrente <= IDLE;
            else
                IndiceVisualizzato<=IndiceVisualizzato+"01";
                stato_corrente <= VISUAL;
            end if;
        end if;
    end if;
end process;

out_prc : process(stato_corrente) begin
    
    mem_write <='0';
    mem_read <= '0';
    clock_load <= '0';
    clock_rst <= '0';
    counting <= '0';
    display_mode <= '0';
    mem_mode <= '0';
    incrementa_intertempi <='0';
        
    if(stato_corrente=START) then
        counting <= '1';

    elsif(stato_corrente=RESET) then 
        clock_rst <= '1';

    elsif(stato_corrente=LOAD) then
        clock_load <= '1';

    elsif(stato_corrente=MEM) then
        mem_write <='1';

    elsif(stato_corrente=INCR) then
        incrementa_intertempi <= '1'; 

    elsif(stato_corrente=VISUAL) then
        mem_read <= '1';
        display_mode <= '1';
        mem_mode <= '1';
        addr <= IndiceVisualizzato;
        
    end if;
end process;
end Behavioral;
