library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity UnitaOperativa_TB is
end UnitaOperativa_TB;

architecture Behavioral of UnitaOperativa_TB is

signal s, d : std_logic_vector(1 downto 0);
signal M1,M2,M3,M4 : std_logic_vector(7 downto 0);
signal O1,O2,O3,O4 : std_logic_vector(7 downto 0);

begin
    uut : entity work.UnitaOperativa port map(
        s=>s, d=>d,
        M1=>M1, M2=>M2, M3=>M3, M4=>M4,
        O1=>O1, O2=>O2, O3=>O3, O4=>O4
    );
    
    process begin
        s <= "00";
        d <= "00";
        M1 <= x"AA";
        M2 <= x"BB";
        M3 <= x"CC";
        M4 <= x"DD";
        wait for 50 ns;
        s <= "01";
        d <= "11";
        wait for 50 ns;
        s <= "11";
        wait;
    end process;

end Behavioral;
