library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity OperativeUnit_A is port(
    clk : in std_logic;
    reset : in std_logic;
    mem_read : in std_logic;
    inc_register : in std_logic;
    
    conteggio : out std_logic_vector(2 downto 0);
    data_out : out std_logic_vector(7 downto 0)
    );
end OperativeUnit_A;

architecture Structural of OperativeUnit_A is
signal countertorom : std_logic_vector(2 downto 0);
begin
rom1 : entity work.rom port map(
    clk=>clk, reset=>'0', read=>mem_read, addr=>countertorom,
    data=>data_out);

cont : entity work.counter port map(
    clk=>clk, rst=>reset, count=>inc_register, load=>'0', parallel_input=>(others=>'0'),
    Y=>countertorom);
    
conteggio <= countertorom;

end Structural;
