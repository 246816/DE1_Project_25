library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity echo_meas is

    port(
        clk : in std_logic;
        rst : in std_logic;
        echo : in std_logic;
        done : out std_logic;
        pulse_len : out unsigned(20 downto 0)
    );

end echo_meas;

architecture Behavioral of echo_meas is

    signal sig_count : unsigned(20 downto 0) := (others => '0');
    signal sig_pulse_len : unsigned(20 downto 0) := (others => '0');
    signal sig_echo_prev : std_logic := '0';
    signal sig_measuring : std_logic := '0';
    signal sig_done : std_logic := '0';

begin

    process(clk)
    begin
    
        if(rising_edge(clk)) then
        
            if(rst = '1') then
            
                sig_count <= (others => '0');
                sig_pulse_len <= (others => '0');
                sig_echo_prev <= '0';
                sig_measuring <= '0';
                sig_done <= '0';
                
            else
   
                sig_echo_prev <= echo;
                sig_done <= '0';
                
                if(sig_echo_prev = '0' and echo = '1') then
                
                    sig_count <= (others => '0');
                    sig_measuring <= '1';
                    
                elsif(sig_measuring = '1') then
                
                    sig_count <= sig_count + 1;
                    
                    if(sig_echo_prev = '1' and echo = '0') then
                        
                        sig_pulse_len <= sig_count; 
                        sig_measuring <= '0';
                        sig_done <= '1';
                    
                    end if;
                
                end if;
            
            end if;
        
        end if;
    
    end process;

    pulse_len <= sig_pulse_len;
    done <= sig_done;

end Behavioral;