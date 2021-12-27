library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SwitchMultistadio_TB is
end SwitchMultistadio_TB;

architecture Behavioral of SwitchMultistadio_TB is

signal X1,X2,X3,X4 : std_logic_vector(7 downto 0);
signal s1,s2,s3,s4 : std_logic;
signal Y1,Y2,Y3,Y4 : std_logic_vector(7 downto 0);

begin
    uut : entity work.SwitchMultistadio port map(
        X1=>X1,X2=>X2,X3=>X3,X4=>X4,
        s1=>s1,s2=>s2,s3=>s3,s4=>s4,
        Y1=>Y1,Y2=>Y2,Y3=>Y3,Y4=>Y4
    );
    
    process begin
        X1 <= "00" & "01" & x"A";
        X2 <= "01" & "00" & x"B";
        X3 <= "10" & "10" & x"C";
        X4 <= "11" & "10" & x"D";
        s1 <= '1';
        s2 <= '0';
        s3 <= '0';
        s4 <= '1';
        wait for 50 ns;
        s4 <= '0';
        s2 <= '1';
        wait for 50 ns;
        X2 <= "01" & "01" & x"B";
        wait for 50 ns;
        s2 <= '0';
        wait;
    end process;
end Behavioral;
