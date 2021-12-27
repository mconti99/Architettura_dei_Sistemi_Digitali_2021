library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparatore is port(
    s1 : in std_logic_vector(7 downto 0);
    s2 : in std_logic_vector(7 downto 0);
    o : out std_logic_vector(7 downto 0));
end comparatore;

architecture Structural of comparatore is
component sommatore is
    port(
        s1 : in std_logic_vector(7 downto 0);
        s2 : in std_logic_vector(7 downto 0);

        sub : in std_logic;
        
        o : out std_logic_vector(7 downto 0);
        cout : out std_logic
    );
end component;

component zero_check is port(
    x : in std_logic_vector(7 downto 0);
    o : out std_logic
    );
end component;

component Multiplexer is
    generic(
    N : integer := 32);
    port(
    in1 : in std_logic_vector(N-1 downto 0);
    in2: in std_logic_vector(N-1 downto 0);
    o: out std_logic_vector(N-1 downto 0);
    s : in std_logic
    );
end component;

signal x : std_logic_vector(7 downto 0);
signal s : std_logic;
begin

sub : sommatore port map(
    s1=>s1, s2=>s2, sub=>'1', o=>x);

controllo_zero : zero_check port map(
    x=>x, o=>s);

m : multiplexer generic map(N=>8) port map(
    in1=>x"FF", in2=>x"00", o=>o, s=>s);
end Structural;
