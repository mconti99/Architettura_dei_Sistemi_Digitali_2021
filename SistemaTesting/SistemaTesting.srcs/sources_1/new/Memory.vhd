

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;


entity Memory is
    generic(
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
end Memory;

architecture Behavioral of Memory is
type mem is array (M-1 downto 0) of std_logic_vector(N-1 downto 0);
signal data : mem := (others=>(others=>'0'));
begin
proc : process(clk) begin
    if rising_edge(CLK) then
        if(rst='1') then
            data<=(others=>(others=>'0'));
        elsif(write='1') then
            data(conv_integer(address))<=input;
        elsif(read='1') then
            output <= data(conv_integer(address));
        else 
            output <= (others=>'Z');
        end if;
    end if;
end process;

end Behavioral;
