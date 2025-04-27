library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity threshold is
    port ( 
        distance : in unsigned(15 downto 0);
        LED : out std_logic_vector(9 downto 0)
    );
end threshold;

architecture Behavioral of threshold is

begin

    process(distance)
    
        variable temp_leds : std_logic_vector(9 downto 0);
        variable number_of_leds: integer;
    
    begin
    
        temp_leds := (others => '0');
        
        number_of_leds := to_integer(distance) / 10;
        
        if(number_of_leds > 10) then
            
            number_of_leds := 10;
        
        end if;
        
        for i in 0 to 9 - 1 loop
        
            -- Hotfix because of the elaborated design error when computing loop on undefined number of leds
            if(i < number_of_leds) then
        
                temp_leds(i) := '1';
        
            else 
                
                temp_leds(i) := '0';
                
            end if;
        
        end loop;
        
        LED <= temp_leds;
    
    end process;

end Behavioral;
