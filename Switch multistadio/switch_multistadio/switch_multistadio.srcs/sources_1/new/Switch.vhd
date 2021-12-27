library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity Switch is
    port(
        in1 : in std_logic_vector(7 downto 0);
        in2 : in std_logic_vector(7 downto 0);
        
        s : in std_logic;
        d : in std_logic;
        
        out1 : out std_logic_vector(7 downto 0);
        out2 : out std_logic_vector(7 downto 0)
    );
end Switch;

architecture Structural of Switch is

signal muxtodemux : std_logic_vector(7 downto 0);

begin
    mux : entity work.Mux generic map(
        N => 8
    ) port map(
        in1 => in1, in2 => in2, s => s, o => muxtodemux
    );

    demux : entity work.Demux generic map(
        N => 8
    ) port map(
        ins => muxtodemux, d => d, o1 => out1, o2 => out2
    );
end Structural;
