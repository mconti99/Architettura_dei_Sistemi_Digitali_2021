----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2021 17:11:53
-- Design Name: 
-- Module Name: ConnectionNet - Structural
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ConnectionNet is
    PORT(
        X : in STD_LOGIC_VECTOR(15 downto 0);
        S : in STD_LOGIC_VECTOR(3 downto 0);
        D : in STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0)
       );
end ConnectionNet;

architecture Structural of ConnectionNet is
signal u : STD_LOGIC;
signal X_set : STD_LOGIC_VECTOR(15 downto 0);

COMPONENT Mux16_1 IS
    PORT(
        X : in STD_LOGIC_VECTOR(15 downto 0);
        S: in STD_LOGIC_VECTOR(3 downto 0);
        Y : out STD_LOGIC
       );
END COMPONENT;

COMPONENT Demux1_4 IS
    PORT(
        X : in STD_LOGIC;
        S : in STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0)
       );
END COMPONENT;
begin
    X_set <= "101010" & X(9 downto 0);
    
    Mux : Mux16_1 PORT MAP(
        X => X_set,
        S => S,
        Y => U
       );
    
    Demux : Demux1_4 PORT MAP(
        X => u,
        S => D,
        Y => Y
       );

end Structural;
