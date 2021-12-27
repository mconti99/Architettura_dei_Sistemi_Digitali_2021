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

entity OperativeUnit_B is port(
    clk : in std_logic;
    
    inc_cont_mem : in std_logic;
    rst : in std_logic;
    mem_write : in std_logic;
    buffer1_write : in std_logic;
    buffer2_write : in std_logic;
    mode_selection: in std_logic;
    inc_cont_str : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    
    conteggio : out std_logic_vector(2 downto 0));    
end OperativeUnit_B;

architecture Structural of OperativeUnit_B is
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

component sommatore is port(
    s1 : in std_logic_vector(7 downto 0);
    s2 : in std_logic_vector(7 downto 0);
    sub : in std_logic;
    cout : out std_logic;
    o : out std_logic_vector(7 downto 0));
end component;

component Memory is
    generic(
    N: integer := 16; --grandezza blocco di memoria
    M: integer := 8 --quanti blocchi di memoria
    );
    port(
    rst : in std_logic;
    read : in std_logic;
    write : in std_logic;
    clk : in std_logic;
    input : in std_logic_vector(N-1 downto 0);
    output : out std_logic_vector(N-1 downto 0);
    address : in std_logic_vector(integer(ceil(log2(real(M))))-1 downto 0)
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

component comparatore is port(
    s1 : in std_logic_vector(7 downto 0);
    s2 : in std_logic_vector(7 downto 0);
    o : out std_logic_vector(7 downto 0));
end component;


signal adder_out : std_logic_vector(7 downto 0);
signal comparator_out : std_logic_vector(7 downto 0);
signal mem_out : std_logic_vector(7 downto 0);
signal mux_out : std_logic_vector(7 downto 0);
signal buffer1_out : std_logic_vector(7 downto 0);
signal buffer2_out : std_logic_vector(7 downto 0);
signal countertomem : std_logic_vector(1 downto 0);

begin
buffer1 : registro generic map(
    N=>8)
    port map(
    clk=>clk, rst=>rst, write=>buffer1_write, data_in=>data_in, data_out=>buffer1_out);

buffer2 : registro generic map(
    N=>8)
    port map(
    clk=>clk, rst=>rst, write=>buffer2_write, data_in=>data_in, data_out=>buffer2_out);

adder : sommatore port map(
    s1=>buffer1_out, s2=>buffer2_out, sub=>'0', o=>adder_out);
    
comparator : comparatore port map(
    s1=>buffer1_out, s2=>buffer2_out, o=>comparator_out);
    
mux : multiplexer generic map(
    N=>8)
    port map(
    in1=>adder_out, in2=>comparator_out, o=>mux_out, s=>mode_selection);

contatore_memoria: counter generic map(
    M=>4)
    port map(
    clk=>clk, rst=>rst, count=>inc_cont_mem, load=>'0', parallel_input=>(others=>'0'), y=>countertomem);
    
mem : memory generic map(N=>8, M=>4) port map(
    rst=>rst, read=>'0', write=>mem_write, clk=>clk, input=>mux_out, output=>mem_out,
    address=>countertomem);

contatore_stringhe: counter generic map(
    M=>8)
    port map(
    clk=>clk, rst=>rst, count=>inc_cont_str, load=>'0', parallel_input=>(others=>'0'), y=>conteggio);

end Structural;
