----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2021 16:21:09
-- Design Name: 
-- Module Name: PriorityEncoder - Structural
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

entity PriorityEncoder is
    Port(
        X : in STD_LOGIC_VECTOR(9 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0)
       );
end PriorityEncoder;

architecture Structural of PriorityEncoder is
    COMPONENT Arbiter IS
        Port(
            X : in STD_LOGIC_VECTOR(9 downto 0);
            Y : out STD_LOGIC_VECTOR(9 downto 0)
           );
    END COMPONENT;
    
    COMPONENT Encoder IS
        Port(
            X : in STD_LOGIC_VECTOR(9 downto 0);
            Y : out STD_LOGIC_VECTOR(3 downto 0)
           );
    END COMPONENT;
    

    signal u : STD_LOGIC_VECTOR(9 downto 0);
begin

    A : Arbiter 
        PORT MAP( 
            X => X,
            Y => u
        );
    
    E : Encoder 
        PORT MAP(
            X => u,
            Y => Y
        );

end Structural;
