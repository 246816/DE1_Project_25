library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity convertor is
    generic(
        MAX_DISCTANCE_CM : integer := 100        
    );
    port(

        echo            : in    std_logic;
        -- Not CLK100MHz but the pulses from clk_en
        clk             : in    std_logic;
        distance        : out   std_logic_vector(7 downto 0)
    );

end convertor;

architecture Behavioral of convertor is

    constant SPEED_OF_WAVE : integer := 343;

    constant SCALING_FACTOR : integer := 20000;

    signal sig_count_en : std_logic;

    signal sig_count : unsigned(19 downto 0) := (others => '0');

    signal sig_echo : std_logic := '0';

    signal sig_distance : std_logic_vector(7 downto 0) := (others => '0');

    begin

        proc_calc_distance : process(clk) is
            begin
            
            if clk'event and clk = '1' then

                if(echo = '1' and sig_count_en = '1') then
                    
                    sig_count_en <= '1';

                    sig_count <= (others => '0');

                elsif (echo = '0' and sig_count_en = '1') then
                    
                    sig_count_en <= '0';

                    sig_distance <= std_logic_vector(to_unsigned((to_integer(sig_count) * SPEED_OF_WAVE) / SCALING_FACTOR, 8));

                end if;

                sig_echo <= echo;

                if(sig_count_en = '1') then

                    sig_count <= sig_count + 1;

                end if;

            end if;

        end process;

        distance <= sig_distance;

end Behavioral;