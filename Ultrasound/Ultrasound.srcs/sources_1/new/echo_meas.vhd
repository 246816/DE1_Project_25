library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- This entity handles the echo pulse from HS-RS04 and measures the pulse length
-- Inputs are clock signal, reset signal and echo signal which is being measured
-- Outputs the done signal once the measuring is completed and pulse length
entity echo_meas is

    port(
        clk : in std_logic;
        rst : in std_logic;
        -- Echo pulse taken directly from the HS-RS04
        echo : in std_logic;
        done : out std_logic;
        pulse_len : out unsigned(20 downto 0)
    );

end echo_meas;

architecture Behavioral of echo_meas is

    -- Internal signal for counting how long the echo pulse was 1
    signal sig_count : unsigned(20 downto 0) := (others => '0');
    -- Internal signal for storing the final pulse length
    signal sig_pulse_len : unsigned(20 downto 0) := (others => '0');
    -- Holds previous echo value for edge detection
    signal sig_echo_prev : std_logic := '0';
    -- Stays 1 while the measuring is being done
    signal sig_measuring : std_logic := '0';
    -- Outputs 1 after the measuring is done
    signal sig_done : std_logic := '0';

begin

    -- PRocess automatically runs when the clk is changed
    process(clk)
    begin
    
        if(rising_edge(clk)) then
        
            -- Resets all the internal signals on rst pulse
            if(rst = '1') then
            
                sig_count <= (others => '0');
                sig_pulse_len <= (others => '0');
                sig_echo_prev <= '0';
                sig_measuring <= '0';
                sig_done <= '0';
                
            else
                    
                -- Updates previous echo value
                sig_echo_prev <= echo;
                -- Done is 0 until the pulse is measured
                sig_done <= '0';
                
                -- Previous echo was 0 and current is 1 so there is rising edge of echo signal
                if(sig_echo_prev = '0' and echo = '1') then
                
                    -- Resets count signal
                    sig_count <= (others => '0');
                    -- Starts measuring
                    sig_measuring <= '1';
                    
                -- If is already measuring
                elsif(sig_measuring = '1') then
                
                    -- Adds 1 to echo duration
                    sig_count <= sig_count + 1;
                    
                    -- Previous echo was 1 and current is 0 so the echo pulse ended
                    if(sig_echo_prev = '1' and echo = '0') then
                        
                        -- Updates pulse length
                        sig_pulse_len <= sig_count; 
                        -- Ends measuring and outputs the done signal
                        sig_measuring <= '0';
                        sig_done <= '1';
                    
                    end if;
                
                end if;
            
            end if;
        
        end if;
    
    end process;

    -- Updates output signals accordingly
    pulse_len <= sig_pulse_len;
    done <= sig_done;

end Behavioral;