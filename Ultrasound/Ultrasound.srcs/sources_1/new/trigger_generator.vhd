library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity trigger_generator is

    port(
        clk : in std_logic;
        rst : in std_logic;
        trig : out std_logic
    );

end trigger_generator;

architecture Behavioral of trigger_generator is

    constant time_10us : natural := 1000;
    constant time_60ms : natural := 6000000;
    
    signal sig_counter : unsigned(22 downto 0) := (others => '0');
    signal sig_trig : std_logic := '0';

begin

    process(clk)
    begin
    
        if(rising_edge(clk)) then
        
            if(rst = '1') then
            
                sig_counter <= (others => '0');
                sig_trig <= '0';
            
            else 
            
                if(sig_counter <= time_60ms) then
                
                    sig_counter <= sig_counter + 1;
                    
                else
   
                    sig_counter <= (others => '0');
                
                end if;
                
                if(sig_counter <= time_10us) then
                
                    sig_trig <= '1';
                    
                else
    
                    sig_trig <= '0';
                
                end if;
               
            end if;
        
        end if;
    
    end process;

    trig <= sig_trig;

end Behavioral;