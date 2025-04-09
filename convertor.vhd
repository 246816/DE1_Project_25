library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity convertor is

    generic(
        -- Max distance in centimeters
        max_distance : integer := 100; 
    );

    port(
        -- Not CLK100MHz but the pulses from clk_en
        clk_en_pulse    : in    std_logic;
        -- BTNC
        rst             : in    std_logic;
        -- Sensor output
        sensor_signal   : in    std_logic;
        distance        : out   std_logic_vector(6 downto 0)
    );

end convertor;

architecture Behavioral of convertor is

    constant SPEED_OF_WAVE : integer := 0.343;

    signal sig_count : integer range 0 to max_distance - 1;

    begin

        proc_calc_distance : process(clk_en_pulse) is
            begin
            
            -- Maybe unnecessary
            if clk_en_pulse'event and clk_en_pulse = '1' then

                if(rst = '1') then
                    
                    sig_count <= 0;

                elsif (sig_count < max_distance - 1) then
                    if sensor_signal = '0' then

                        -- TODO: Logic to convert x count to distance
                            -- sig_count <= (sig_count * SPEED_OF_WAVE) / 2; ??

                        distance <= sig_count;

                    else
                        sig_count <= sig_count + 1;

                    end if;

                else 
                    sig_count <= 0;

                end if;

            end if;

        end process;

end Behavioral;
