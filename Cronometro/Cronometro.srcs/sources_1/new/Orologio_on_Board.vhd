library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;


entity Orologio_on_Board is
    port(
        clk: in std_logic;
        
        start_b : in std_logic;
        rst_b: in std_logic;
        load_b : in std_logic;
        mem_b : in std_logic;
        visual_b : in std_logic;  
              
        min_in : in std_logic_vector(5 downto 0);
        hour_in : in std_logic_vector(4 downto 0);
        
        anodes :out std_logic_vector(7 downto 0);
        cathodes: out std_logic_vector(7 downto 0)
    );
end Orologio_on_Board;

architecture Structural of Orologio_on_Board is


component ControlUnit is
    port(
        clk : in std_logic;
        mem_write : out std_logic;
        mem_read : out std_logic;
        clock_load : out std_logic;
        clock_rst : out std_logic;
        incrementa_intertempi : out std_logic; --abilita il contatore degli intertempi 
        counting : out std_logic; --ingresso del ff che memorizza lo stato (del cronometro)
        display_mode : out std_logic; --selezione multiplexer del visore
        mem_mode : out std_logic; --selezione multiplexer della memory
        n_intertempi : in std_logic_vector(1 downto 0); --uscita del contatore degli intertempi
        start_b : in std_logic;
        rst_b: in std_logic;
        load_b : in std_logic;
        mem_b : in std_logic;
        visual_b : in std_logic;
        addr : out std_logic_vector(1 downto 0)
    );
end component;

component DataPath is
    port(
        clk: in std_logic;

        -- Ingressi di controllo
        mem_write : in std_logic; 
        mem_read : in std_logic;
        clock_load : in std_logic;
        clock_rst : in std_logic;
        incrementa_intertempi : in std_logic; --abilita il contatore degli intertempi 
        counting : in std_logic; --ingresso del ff che memorizza lo stato (del cronometro)
        display_mode : in std_logic; --selezione multiplexer del visore
        mem_mode : in std_logic; --selezione multiplexer della memor
        addr : in std_logic_vector(1 downto 0);
        
        -- Ingressi utente       
        min_in : in std_logic_vector(5 downto 0);
        hour_in : in std_logic_vector(4 downto 0);
        
        -- Stato
        n_intertempi : out std_logic_vector(1 downto 0); --uscita del contatore degli intertempi

        -- Segnali di uscita
        anodes :out std_logic_vector(7 downto 0);
        cathodes: out std_logic_vector(7 downto 0)
    );
end component;

component ButtonDebouncer is
    generic (                       
        CLK_period:   integer := 10;  -- periodo del clock della board 10 nanosecondi
        btn_noise_time:   integer := 6500000 --intervallo di tempo in cui si ha l'oscillazione del bottone
    );
    Port ( 
        RST : in STD_LOGIC;
        CLK : in STD_LOGIC;
        BTN : in STD_LOGIC;
        CLEARED_BTN : out STD_LOGIC
    );
end component;

--UC 
signal clock_load : std_logic;
signal clock_rst : std_logic;
signal counting : std_logic;
signal mem_read : std_logic;
signal mem_write : std_logic;
signal mem_mode : std_logic;
signal display_mode : std_logic;
signal addr : std_logic_vector(1 downto 0);
signal incrementa_intertempi : std_logic;


--CONTATORE INTERTEMPI
signal n_intertempi : std_logic_vector(1 downto 0);


--BOTTONI
signal cleared_mem : std_logic;
signal cleared_start: std_logic;
signal cleared_visual : std_logic; 

begin
    
    CU : ControlUnit port map(
        clk=>clk, mem_write=>mem_write, 
        mem_read=>mem_read, clock_load=> clock_load, clock_rst=>clock_rst, 
        incrementa_intertempi=>incrementa_intertempi, counting=>counting,
        display_mode=>display_mode, mem_mode=>mem_mode, n_intertempi=>n_intertempi, 
        start_b=>cleared_start, rst_b=>rst_b, load_b=>load_b,
        mem_b=>cleared_mem, visual_b=>cleared_visual, addr=>addr
    );
    
    DP : DataPath port map(
        clk => clk, mem_write => mem_write, mem_read => mem_read, clock_load => clock_load,
        clock_rst => clock_rst, incrementa_intertempi => incrementa_intertempi, 
        counting => counting, display_mode  => display_mode, mem_mode => mem_mode,
        addr => addr, min_in  => min_in, hour_in => hour_in,
        n_intertempi => n_intertempi, anodes => anodes, cathodes => cathodes
     );
        
    MemDebouncer : ButtonDebouncer generic map(
        CLK_period=>10, btn_noise_time=>325000000)
        port map(
        rst=>'0', clk=>clk, btn=>mem_b, cleared_btn=>cleared_mem);
        
    StartDebouncer : ButtonDebouncer generic map(
        CLK_period=>10, btn_noise_time=>325000000)
        port map(
        rst=>'0', clk=>clk, btn=>start_b, cleared_btn=>cleared_start);
        
    VisualDebouncer : ButtonDebouncer generic map(
        CLK_period=>10, btn_noise_time=>325000000)
        port map(
        rst=>'0', clk=>clk, btn=>visual_b, cleared_btn=>cleared_visual);
end Structural;
