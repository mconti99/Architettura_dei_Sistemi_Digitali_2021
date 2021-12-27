----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2021 15:59:41
-- Design Name: 
-- Module Name: Mux4_1 - Structural
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

entity Mux4_1 is
    Port(
        X : in STD_LOGIC_VECTOR(3 downto 0);
        S : in STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC
       );
end Mux4_1;

architecture Structural of Mux4_1 is

COMPONENT Mux2_1 IS
    Port(
        X : in STD_LOGIC_VECTOR(1 downto 0);
        S : in STD_LOGIC;
        Y : out STD_LOGIC
       );
END COMPONENT;
signal U : STD_LOGIC_VECTOR(1 downto 0);
begin
    Mux0to2 : FOR i IN 0 TO 2 GENERATE
        M01: IF i < 2 GENERATE
            M : Mux2_1 PORT MAP(
                X => X(i*2+1 downto i*2),
                S => S(0),
                Y => U(i)
               );
        END GENERATE;
        
        M2: IF i = 2 GENERATE
            M : Mux2_1 PORT MAP(
                X => U,
                S => S(1),
                Y => Y
               );
         END GENERATE;
    END GENERATE;
        


end Structural;
