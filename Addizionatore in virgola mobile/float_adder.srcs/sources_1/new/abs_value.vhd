library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity abs_value is generic(
        N : integer := 8
    );
     port(
        X : in std_logic_vector(N-1 downto 0);
        Y : out std_logic_vector(N-1 downto 0)
    );
end abs_value;

architecture Structural of abs_value is

signal not_X : std_logic_vector(N-1 downto 0);
signal zeros : std_logic_vector(N-2 downto 0);
signal b_port : std_logic_vector(N-1 downto 0);
signal neg_plus_one : std_logic_vector(N-1 downto 0);

begin
    zeros <= (others => '0');
    b_port <= zeros & '1';
    not_X <= not X;

    
    addr : entity work.ripple_carry_adder generic map(
        N=>N
    ) port map (
        a => not_X, b => b_port, sub => '0', res => neg_plus_one
    );

    with X(N-1) select
        Y <= X when '0',
             neg_plus_one when '1',
             X when others;

end Structural;
