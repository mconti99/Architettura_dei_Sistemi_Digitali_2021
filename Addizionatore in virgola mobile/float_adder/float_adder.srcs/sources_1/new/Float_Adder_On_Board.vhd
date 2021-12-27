

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;


entity Float_Adder_On_Board is port(
    clk : in std_logic;
    start_b : in std_logic;
    
    anodes : out std_logic_vector(7 downto 0);
    cathodes : out std_logic_vector(7 downto 0));
end Float_Adder_On_Board;

architecture Structural of Float_Adder_On_Board is

signal value : std_logic_vector(31 downto 0);
begin
adder: entity work.floatadder port map(clk=>clk,start_b=>start_b,
    res=>value, op1=>"01000010001010011010111000010100",op2=>"01000001101110011110101110000101");

display_7_segment : entity work.display port map(clk=>clk, rst=>'0',
    value=>value, enable=>(others=>'1'), dots=>(others=>'0'),
    anodes=>anodes, cathodes=>cathodes);
    
end Structural;
