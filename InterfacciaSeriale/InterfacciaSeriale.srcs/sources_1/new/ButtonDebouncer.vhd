----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.11.2021 18:32:51
-- Design Name: 
-- Module Name: ButtonDebouncer - Behavioral
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

entity ButtonDebouncer is
    generic(
        CLK_PERIOD : integer := 10;
        btn_noise_time: integer :=6500000);
    port(
    clk : in std_logic;
    reset : in std_logic;
    btn : in std_logic;
    cleared_btn : out std_logic --dura quanto un colpo di clock
    );
end ButtonDebouncer;
--il button bouncing costituisce un problema quando il segnale
--associato al bottone viene utilizzato per far evolvere lo stato del sistema

architecture Behavioral of ButtonDebouncer is
type stato is (NOT_PRESSED, PRESSED);
SIGNAL btn_state : stato := NOT_PRESSED;

constant m : integer := btn_noise_time/CLK_PERIOD;
begin
deb: process(CLK)
variable count: integer :=0;

begin
    if rising_edge(CLK) then
        if(reset='1') then
            btn_state<=NOT_PRESSED;
            CLEARED_BTN <='0';
        else 
            case BTN_state is
                when NOT_PRESSED=>
                    CLEARED_BTN <= '0';
                    if(BTN='1') then BTN_state <= PRESSED;
                    else BTN_STATE <= NOT_PRESSED;
                    end if;
                when PRESSED =>
                    IF(COUNT =m-1) then
                        count:=0;
                        CLEARED_BTN <='1';
                        BTN_STATE <= not_PRESSED;
                    else 
                        count:=count+1;
                        btn_state <= pressed;
                    END IF;
                 when others => BTN_STATE <= NOT_PRESSED;
             end case;
         end if;
     end if;
end process;
end Behavioral;
