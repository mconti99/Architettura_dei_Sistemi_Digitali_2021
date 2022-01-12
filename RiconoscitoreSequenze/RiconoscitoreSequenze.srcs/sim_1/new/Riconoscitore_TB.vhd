library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Riconoscitore_TB is
end Riconoscitore_TB;

architecture Behavioral of Riconoscitore_TB is
    component Riconoscitore is port(
        clk : in std_logic;
        i : in std_logic;
        i_read : in std_logic;
        o : out std_logic;
        m : in std_logic;
        m_read : in std_logic;
        state : out std_logic_vector(3 downto 0)
    );
    end component;
    
    signal clk : std_logic := '0';
    signal i : std_logic := '0';
    signal o : std_logic := '0';
    signal m : std_logic := '0';
    signal i_read : std_logic :='0';
    signal m_read : std_logic := '0';
    signal state : std_logic_vector(3 downto 0);
    
begin

    uut : Riconoscitore port map(
       clk => clk, i => i, o => o, m => m, i_read=>i_read, m_read=>m_read, state=>state
    );

    tb_clock : process begin
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
        clk <='0';
    end process;
    
    tb_inputs : process begin
        
--        wait for 10 ns;
--        i_read <= '1';
--        i <= '1';
--        wait for 100 ns;
--        i_read <= '1';
--        i <= '0';
--        wait for 100 ns;
--        i_read <= '1';
--        i <= '0';
--        wait for 100 ns;
--        i_read <= '1';
--        i <= '1';
--        wait for 5 ns;
--        i_read <= '1';
--        i <= '0';
--        wait for 5 ns;
--        i_read <= '1';
--        i <= '1';
--        wait for 5 ns;
--        i_read <= '1';
--        i <= '0';
--        wait for 5 ns;
--        i_read <= '1';
--        i <= '1';
        
--        wait for 100 ns;
--        i_read <= '0';
--        m_read <= '1';
--        m <= '1';
--        wait for 50 ns;
--        m_read <= '0';
--        i_read <= '1';
--        i <= '1';
--        wait for 50 ns;
--        i_read <= '1';
--        i <= '0';
--        wait for 50 ns;
--        i_read <= '1';
--        i <= '0';
--        wait for 50 ns;
--        i_read <= '1';
--        i <= '1';
--        wait;
        
        wait for 100 ns;
        i_read <= '0';
        m_read <= '1';
        m <= '1';
        wait for 100 ns;
        m_read <= '0';
        i_read <= '1';
        i <= '0';
        wait for 100 ns;
        i_read <= '1';
        i <= '0';
        wait for 100 ns;
        i_read <= '1';
        i <= '1';
        wait for 100 ns;
        i_read <= '1';
        i <= '1';
        wait for 100 ns;
        i_read <= '1';
        i <= '0';
        wait for 100 ns;
        i_read <= '1';
        i <= '0';
        wait for 100 ns;
        i_read <= '1';
        i <= '1';
        wait;
    end process;

end Behavioral;
