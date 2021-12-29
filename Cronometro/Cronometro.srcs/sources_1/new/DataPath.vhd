library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;


entity DataPath is
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
end DataPath;

architecture Structural of DataPath is

component orologio is
    port(
        clk, rst, load, count : in std_logic;
        sec_in : in std_logic_vector(5 downto 0);
        min_in : in std_logic_vector(5 downto 0);
        hour_in : in std_logic_vector(4 downto 0);
        
        sec : out std_logic_vector(5 downto 0);
        min : out std_logic_vector(5 downto 0);
        hour : out std_logic_vector(4 downto 0)
    );
end component;

component  display_seven_segments is
	Generic( 
		CLKIN_freq : integer := 100000000; 
		CLKOUT_freq : integer := 500
	);
    Port( 
        CLK : in  STD_LOGIC;
        RST : in  STD_LOGIC;
        VALUE : in  STD_LOGIC_VECTOR (31 downto 0);
        ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
        DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
        ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
        CATHODES : out  STD_LOGIC_VECTOR (7 downto 0)
    );
end component;

component BCDConverter is 
    port( 
        x : in std_logic_vector(5 downto 0);
        y: out std_logic_vector(7 downto 0)
    );
end component;

component ff_t is port(
        T : in std_logic;
        rst : in std_logic;
        clk: in std_logic;
        q: out std_logic
    );
end component;

component memory is generic(
        N: integer := 32; --grandezza blocco di memoria
        M: integer := 8 --quanti blocchi di memoria
    );
    port(
        rst : in std_logic;
        read : in std_logic;
        write : in std_logic;
        clk : in std_logic;
        input : in std_logic_vector(N-1 downto 0);
        output : out std_logic_vector(N-1 downto 0);
        address : in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0)
    );
end component;

component multiplexer is generic(
        N : integer := 32);
    port(
        in1 : in std_logic_vector(N-1 downto 0);
        in2: in std_logic_vector(N-1 downto 0);
        o: out std_logic_vector(N-1 downto 0);
        s : in std_logic
    );
end component;

component counter is generic(
        M : integer := 8
    );
    port(
        clk, rst, count, load : in std_logic;
        parallel_input : in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
        clk_out : out std_logic;
        Y : out std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0)
    );
end component;

--MEM
signal mem_out : std_logic_vector(31 downto 0);
signal mem_addr: std_logic_vector(2-1 downto 0);


--VISORE
signal muxtovis : std_logic_vector(31 downto 0);

signal counter_intertempi : std_logic_vector(1 downto 0);

signal ff_out : std_logic;

signal value_in : std_logic_vector(31 downto 0);
signal secBCD : std_logic_vector(7 downto 0);
signal minBCD : std_logic_vector(7 downto 0);
signal hourBCD : std_logic_vector(7 downto 0);

signal secEX: std_logic_vector(5 downto 0);
signal minEX: std_logic_vector(5 downto 0);
signal hourEX : std_logic_vector(5 downto 0);

begin

    value_in <= x"00" & hourBCD & minBCD & secBCD; --time, uscita del bcd converter
    hourEX(5)<='0';

    n_intertempi <= counter_intertempi;

    Orol : orologio port map(
        clk=>clk, rst=>clock_rst, load => clock_load, count=>ff_out,sec_in=>(others=>'0'),min_in=>min_in,hour_in=>hour_in, sec=> secEX,min=>minEX,hour=>hourEX(4 downto 0)
    );
    
    Visore : display_seven_segments port map(
        CLK=>CLK,RST=>'0',VALUE=>muxtovis,DOTS=>"00010100", ENABLE=>"00111111", ANODES=>anodes,cathodes=>cathodes
    );
    
    ConvSec : BCDConverter port map(
        x => secEX, y => secBCD
    );
        
    ConMin : BCDConverter port map(
        x => minEX, y => minBCD
    );
        
    ConvHour : BCDConverter port map(
        x => hourEX, y => hourBCD
    ); 
        
        
    FlipFlopT : ff_t port map(
        clk => clk, t => counting, rst => clock_rst , q=>ff_out
    );
    
    Mem : Memory generic map(
        M=>4, N=>32)
        port map(
        read=>mem_read, rst=>clock_rst, clk=>clk, write=>mem_write, output=>mem_out, input=>value_in, address=>mem_addr
    );
    
    CounterIntertempi : Counter generic map(
        M=>4)
        port map(
        clk=>clk, count=>incrementa_intertempi, y => counter_intertempi , rst=>clock_rst, load=>'0', parallel_input => (others=>'0')
    );
    
    MuxDisplay : Multiplexer generic map(
        N => 32
    ) port map (
        in1=>value_in, in2=>mem_out, o=>muxtovis, s=>display_mode
    );

    MuxAddress : Multiplexer generic map(
        N=>2)
        port map(
        in1=>counter_intertempi, in2=>addr, s=>mem_mode, o=>mem_addr
    );
    
end Structural;
