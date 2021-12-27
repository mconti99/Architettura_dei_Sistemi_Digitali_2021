----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2021 16:36:16
-- Design Name: 
-- Module Name: Mux16_1 - Behavioral
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

entity Mux16_1 is
    Port(
        X : in STD_LOGIC_VECTOR(15 downto 0);
        S : in STD_LOGIC_VECTOR(3 downto 0);
        Y : out STD_LOGIC
       );
end Mux16_1;
architecture Structural of Mux16_1 is

COMPONENT Mux4_1 IS
    Port(
        X : in STD_LOGIC_VECTOR(3 downto 0);
        S : in STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC
       );
END COMPONENT;
signal U : STD_LOGIC_VECTOR(3 downto 0);
begin
    Mux0to4 : FOR i IN 0 TO 4 GENERATE
        M03: IF i < 4 GENERATE
            M : Mux4_1 PORT MAP(
                X => X(i*4+3 downto i*4),
                S => S(1 downto 0),
                Y => U(i)
               );
        END GENERATE;
        
        M4: IF i = 4 GENERATE
            M : Mux4_1 PORT MAP(
                X => U,
                S => S(3 downto 2),
                Y => Y
               );
         END GENERATE;
    END GENERATE;
        


end Structural;