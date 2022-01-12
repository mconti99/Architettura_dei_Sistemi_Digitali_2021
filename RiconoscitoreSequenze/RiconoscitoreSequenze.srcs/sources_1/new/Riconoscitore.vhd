library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Riconoscitore is
    port(
        clk : in std_logic;
        i : in std_logic;
        i_read : in std_logic;
        o : out std_logic;
        m : in std_logic;
        m_read : in std_logic;
        state : out std_logic_vector(3 downto 0)
    );
end Riconoscitore;


architecture Behavioral of Riconoscitore is
    type stato is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10);
    signal q : stato := S0;
begin
    update : process(clk) begin
        if(rising_edge(clk)) then

            if(m_read='1') then 
                if(m = '1' and (q = S0 or q = S1 or q = S2 or q = S3 or q = S4 or q = S5 or q = S6)) then 
                    q <= S7;
                    o <= '0';
                elsif(m = '0' and (q = S7 or q = S8 or q = S9 or q = S10)) then 
                    q <= S0;
                    o <= '0';
                end if;

            elsif(i_read = '1') then
                case q is
                    when S0 => 
                        if(i = '0') then
                            q <= S4;
                            o <= '0';
                        elsif(i = '1') then
                            q <= S1;
                            o <= '0';
                        end if;
                      
                    when S1 => 
                        if(i = '0') then
                            q <= S2;
                            o <= '0';
                        elsif(i = '1') then
                            q <= S5;
                            o <= '0';
                        end if;
                        
                    when S2 => 
                        if(i = '0') then
                            q <= S3;
                            o <= '0';
                        elsif(i = '1') then
                            q <= S6;
                            o <= '0';
                        end if;
                        
                    when S3 => 
                        if(i = '0') then
                            q <= S0;
                            o <= '0';
                        elsif(i = '1') then
                            q <= S0;
                            o <= '1';
                        end if;
                        
                      when S4 => 
                            q <= S5;
                            o <= '0';
                      
                      when S5 => 
                            q <= S6;
                            o <= '0';
                        
                      when S6 =>
                            q <= S0;
                            o <= '0';
                      
                    when S7 => 
                        if(i = '0') then
                            q <= S7;
                            o <= '0';
                        elsif(i = '1') then
                            q <= S8;
                            o <= '0';
                        end if;
                      
                    when S8 => 
                        if(i = '0') then
                            q <= S9;
                            o <= '0';
                        elsif(i = '1') then
                            q <= S8;
                            o <= '0';
                        end if;
                        
                    when S9 => 
                        if(i = '0') then
                            q <= S10;
                            o <= '0';
                        elsif(i = '1') then
                            q <= S8;
                            o <= '0';
                        end if;
                        
                    when S10 => 
                        if(i = '0') then
                            q <= S7;
                            o <= '0';
                        elsif(i = '1') then
                            q <= S7;
                            o <= '1';
                        end if;
                end case;     
            end if;
        end if;
end process;    
   
with q select
        state <= x"0" when S0,
                 x"1" when S1,
                 x"2" when S2,
                 x"3" when S3,
                 x"4" when S4,
                 x"5" when S5,
                 x"6" when S6,
                 x"7" when S7,
                 x"8" when S8,
                 x"9" when S9,
                 x"a" when S10,
                 x"f" when others;
    
end Behavioral;