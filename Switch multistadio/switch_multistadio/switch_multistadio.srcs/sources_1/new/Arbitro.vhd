library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Arbitro is
    port(
        s1,s2,s3,s4 : in std_logic;
        selected : out std_logic_vector(1 downto 0)
    );
end Arbitro;

architecture Dataflow of Arbitro is
begin
    selected <= "11" when s4 = '1' else
              "10" when s3 = '1' else
              "01" when s2 = '1' else
              "00" when s1 = '1' else
              "--";
end Dataflow;
