library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux is
    generic(
    N : integer := 4);
    port(
    in1 : in std_logic_vector(N-1 downto 0);
    in2: in std_logic_vector(N-1 downto 0);
    o: out std_logic_vector(N-1 downto 0);
    s : in std_logic
    );
end Mux;

architecture Dataflow of Mux is

begin
with s select
    o <= in1 when '0',
         in2 when '1',
         (others=>'Z') when others;

end Dataflow;
