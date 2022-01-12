library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Riconoscitore_on_board is
    port(
        clk : in std_logic;
        i : in std_logic;
        i_read : in std_logic;
        o : out std_logic;
        m : in std_logic;
        m_read : in std_logic;
        state : out std_logic_vector(3 downto 0)
    );
end Riconoscitore_on_board;

architecture Behavioral of Riconoscitore_on_board is

component Riconoscitore port(
    clk : in std_logic;
    i : in std_logic;
    i_read : in std_logic;
    o : out std_logic;
    m : in std_logic;
    m_read : in std_logic;
    state : out std_logic_vector(3 downto 0)
);
end component;

component ButtonDebouncer generic (                       
    CLK_period:   integer := 10;  
    btn_noise_time:   integer := 6500000
);
Port ( 
    ReSeT : in STD_LOGIC;
    CLK : in STD_LOGIC;
    BTN : in STD_LOGIC;
    CLEARED_BTN : out STD_LOGIC
);
end component;

signal cleared_i : std_logic;
signal cleared_m : std_logic;

begin
    
    debi : ButtonDebouncer generic map(
        CLK_period => 10,   btn_noise_time => 650000000
    ) port map (
        ReSeT => '0', clk => clk, BTN => i_read, cleared_btn => cleared_i
    );
    
    debm : ButtonDebouncer generic map(
        CLK_period => 10,   btn_noise_time => 650000000
    ) port map (
        ReSeT => '0', clk => clk, BTN => m_read , cleared_btn => cleared_m
    );
    
    asf : Riconoscitore port map(
        clk => clk, i => i, m => m, state => state, o => o, i_read => cleared_i, m_read => cleared_m
    );

end Behavioral;