----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2021 10:31:13
-- Design Name: 
-- Module Name: Datapath_B - Structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


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

entity Datapath_B is port(
    clk : in std_logic;
    
    inc_register : in std_logic;
    rst : in std_logic;
    buffer_write : in std_logic;
    msg_read : in std_logic;
    mem_read : in std_logic;
    mem_write : in std_logic;
    enable_visore : in std_logic;
    switch_mode : in std_logic;
     
    msg_in : in std_logic_vector(15 downto 0);
    in_switch : in std_logic_vector(2 downto 0);--ingresso dello switch
    
    anodes : out std_logic_vector(7 downto 0);
    cathodes : out std_logic_vector(7 downto 0));
end Datapath_B;

architecture Structural of Datapath_B is
component registro is
    generic(
        N : integer := 8
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        write : in std_logic;
        data_in : in std_logic_vector(N-1 downto 0);
        data_out : out std_logic_vector(N-1 downto 0)
        );     
end component;

component counter is
generic(
        M : integer := 8
    );
    port(
        clk, rst, count, load : in std_logic;
        parallel_input : in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0);
        clk_out : out std_logic;
        Y : out std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0)
    );
end component;

component adder is port(
    s1 : in std_logic_vector(15 downto 0);
    s2 : in std_logic_vector(15 downto 0);
    o : out std_logic_vector(15 downto 0));
end component;

component memory is port(
    rst : in std_logic;
    read : in std_logic;
    write : in std_logic;
    clk : in std_logic;
    input : in std_logic_vector(15 downto 0);
    output : out std_logic_vector(15 downto 0);
    address : in std_logic_vector(2 downto 0)
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

component display_seven_segments is generic(
				CLKIN_freq : integer := 100000000; 
				CLKOUT_freq : integer := 500
				);
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           VALUE : in  STD_LOGIC_VECTOR (31 downto 0);
           ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
           DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
           ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
           CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal msg_out : std_logic_vector(15 downto 0);
signal adder_out : std_logic_vector(15 downto 0);
signal tamp_out : std_logic_vector(15 downto 0);
signal mem_out : std_logic_vector(15 downto 0);
signal count_out : std_logic_vector(2 downto 0);
signal mux_out : std_logic_vector(2 downto 0);
signal visore_data : std_logic_vector(31 downto 0);
signal abilita_visore : std_logic_vector(7 downto 0);
begin
msg_reg : registro generic map(
    N=>16)
    port map(
    clk=>clk, rst=>rst, write=>msg_read, data_in=>msg_in, data_out=>msg_out);


tamp_reg: registro generic map(--registro tampone per salvare il risultato della addizione
    N=>16)
    port map(
    clk=>clk, rst=>rst, write=>buffer_write, data_in=>adder_out, data_out=>tamp_out);

addizionatore : adder port map(
    s1=>msg_out, s2=>mem_out, o=>adder_out);

mem : memory port map(
    rst=>rst, read=>mem_read, write=>mem_write, clk=>clk, input=>tamp_out, output=>mem_out,
    address=>mux_out);

contatore : counter generic map(
    M=>8)
    port map(
    clk=>clk, rst=>rst, count=>inc_register, load=>'0', parallel_input=>(others=>'0'), y=>count_out);

mux : multiplexer generic map(
    N=>3)
    port map(
    in1=>count_out, in2=>in_switch, o=>mux_out, s=>switch_mode);
    
visore_data<= x"0000"&mem_out;
with enable_visore select
abilita_visore <= x"00" when '0',
                  x"0F" when '1',
                  x"00" when others;
display : display_seven_segments port map(
    clk=>clk, rst=>'0', value=>visore_data, enable=>abilita_visore, dots=>(others=>'0'), anodes=>anodes,
    cathodes=>cathodes);

end Structural;
