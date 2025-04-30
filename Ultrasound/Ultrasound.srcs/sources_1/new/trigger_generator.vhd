library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- This entity periodically generates 10us pulses to trigger the HS-SR04
-- The trigger pulse if repeated every 60ms
-- Inputs are only clock signal and reset signal
-- Outputs the 10us trig signal
entity trigger_generator is

    port(
        clk : in std_logic;
        rst : in std_logic;
        trig : out std_logic
    );

end trigger_generator;

architecture Behavioral of trigger_generator is

    -- Constants for easier readability
    constant time_10us : natural := 1000;
    constant time_60ms : natural := 6000000;
    
    -- Internal signal for counting the elapsed time
    signal sig_counter : unsigned(22 downto 0) := (others => '0');
    -- Holds the trigger signal for 10us and 0 otherwise
    signal sig_trig : std_logic := '0';

begin

    -- Process automatically runs when the clk is changed
    process(clk)
    begin
    
        if(rising_edge(clk)) then
        
            -- Resets the internal signals
            if(rst = '1') then
            
                sig_counter <= (others => '0');
                sig_trig <= '0';
            
            else 
                
                -- If the time is lower than 60ms increments the counter to wait for repeat
                if(sig_counter <= time_60ms) then
                
                    sig_counter <= sig_counter + 1;
                    
                else
                    
                    -- Resets counter when the time is greater than 60ms
                    sig_counter <= (others => '0');
                
                end if;
                
                -- If the time is lower than 10us trigger the trig pulse
                if(sig_counter <= time_10us) then
                
                    sig_trig <= '1';
                    
                else
    
                    sig_trig <= '0';
                
                end if;
               
            end if;
        
        end if;
    
    end process;

    -- Assigns the internal signal to output
    trig <= sig_trig;

end Behavioral;