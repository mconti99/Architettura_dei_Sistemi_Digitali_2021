library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sommatore is
    port(
        s1 : in std_logic_vector(7 downto 0);
        s2 : in std_logic_vector(7 downto 0);

        sub : in std_logic;
        
        o : out std_logic_vector(7 downto 0);
        cout : out std_logic
    );
end sommatore;

architecture Structural of sommatore is

component full_adder is
    port(
        a : in std_logic;
        b : in std_logic;
        cin : in std_logic;
        s : out std_logic;
        cout : out std_logic
    );
end component;

signal b_n : std_logic_vector(7 downto 0);
signal couts : std_logic_vector(7 downto 0);

begin
    
    b_n <= s2 xor (sub&sub&sub&sub&sub&sub&sub&sub);
    cout <= couts(7);

    adders : for i in 0 to 7 generate
        add0: if i = 0 generate
            add : full_adder port map(
                a => s1(0), b=>b_n(0), cin => sub, s => o(0), cout => couts(0)
            );
        end generate;
        add17: if i>0 generate
            add : full_adder port map(
                a => s1(i), b => b_n(i), cin =>couts(i-1), s => o(i), cout => couts(i)
            );
        end generate;
    end generate;
    
end Structural;
