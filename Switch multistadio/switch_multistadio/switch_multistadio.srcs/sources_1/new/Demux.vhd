library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Demux is
    generic(
    N : integer := 4);
    port(
    ins : in std_logic_vector(N-1 downto 0);
    o1: out std_logic_vector(N-1 downto 0);
    o2 : out std_logic_vector(N-1 downto 0);
    d : in std_logic
    );
end Demux;

architecture Dataflow of Demux is

begin

with d select
    o1 <= ins when '0',
          (others => '0') when '1',
          (others => 'Z') when others;

with d select
    o2 <= ins when '1',
          (others => '0') when '0',
          (others => 'Z') when others;

end Dataflow;
