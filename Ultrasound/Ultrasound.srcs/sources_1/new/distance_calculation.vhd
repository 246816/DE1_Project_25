library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- This entity calculates distance in cm from pulse length taken from HS-SR04
-- Inputs are clock signal, reset signal and pulse length from the echo_meas entity
-- Outputs are the number in cm and signal of the computation being done
entity distance_calculation is

    port(
        clk : in std_logic;
        rst : in std_logic;
        -- Pulse length from echo_meas module
        pulse_len : in unsigned(20 downto 0);
        pulse_ready : in std_logic;
        distance : out unsigned(15 downto 0);
        distance_ready : out std_logic
    );

end distance_calculation;

architecture Behavioral of distance_calculation is

    -- Constant for speed of wave in air 343 m/s
    constant speed_of_wave : integer := 343;
    
    -- Internal distance signal for storing the output distance
    signal sig_distance : unsigned(15 downto 0) := (others => '0');
    
    -- Internal distance ready signal once the computation is done
    signal sig_distance_ready : std_logic := '0';

begin

    -- Process automatically runs when the clk is changed
    process(clk)
    begin
    
        if(rising_edge(clk)) then
            
            -- Resets values
            if(rst = '1') then
            
                sig_distance <= (others => '0');
                sig_distance_ready <= '0';
                
            else
   
                sig_distance_ready <= '0';
                
                -- Once the pulse is complete
                if(pulse_ready = '1') then
                
                    -- Calculation of the distance in cm
                    -- Length of pulse is multiplied by the speed of wave and divided by two, 
                    --- because the signal traveled to the object and back
                    -- Then is divided by 100000 because of the frequency of clock signal
                    -- After the calculation is resized to the 16 bit number
                    sig_distance <= resize((pulse_len * speed_of_wave / 2) / 100000, sig_distance'length);
                    -- Distance calculated successfully
                    sig_distance_ready <= '1';
                
                end if;
            
            end if;
        
        end if;
    
    end process;

    -- Assignin of the internal signals into the output 
    distance <= sig_distance;
    distance_ready <= sig_distance_ready;

end Behavioral;