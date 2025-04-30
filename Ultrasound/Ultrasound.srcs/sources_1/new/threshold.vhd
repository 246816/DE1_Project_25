library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- This entity handles the treshold of distance and turns on the LEDs on the nexys board accordingly
-- Inputs the distance in cm and outputs vector of turned on (1) / off (0) LEDs
entity threshold is
    port (
        -- Distance in cm from distance_calculation module
        distance : in unsigned(15 downto 0);
        -- Capped to max 10 LEDs
        LED : out std_logic_vector(9 downto 0)
    );
end threshold;

architecture Behavioral of threshold is

begin

    -- When the distance is changed the process will start automatically again
    process(distance)
    
        -- Temporary variable for storing how many LEDs should be turned on
        variable temp_leds : std_logic_vector(9 downto 0);
        variable number_of_leds: integer;
    
    begin
    
        -- Clearing all LEDs
        temp_leds := (others => '0');
        
        -- Calculates the amount of LEDs to be switched on
        -- 00 - 09 => 0 LEDs
        -- 10 - 19 => 1 LED
        -- etc.
        number_of_leds := to_integer(distance) / 10;
        
        -- If number of LEDs are more than the upper limit there will be only the 10 LEDs on
        if(number_of_leds > 10) then
            
            number_of_leds := 10;
        
        end if;
        
        -- Should be number_of_leds - 1, but the elaborated design had a problem with it
        for i in 0 to 9 - 1 loop
        
            -- Hotfix because of the elaborated design error when computing loop on undefined number of leds
            if(i < number_of_leds) then
        
                temp_leds(i) := '1';
        
            else 
                -- Another check so the error of turing on LEDs that the program doesn't have access to cannot happen
                temp_leds(i) := '0';
                
            end if;
        
        end loop;
        
        -- Passes the number of LEDs to LED output
        LED <= temp_leds;
    
    end process;

end Behavioral;
