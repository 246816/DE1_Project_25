library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity distance_calculation is

    port(
        clk : in std_logic;
        rst : in std_logic;
        pulse_len : in unsigned(20 downto 0);
        pulse_ready : in std_logic;
        distance : out unsigned(15 downto 0);
        distance_ready : out std_logic
    );

end distance_calculation;

architecture Behavioral of distance_calculation is

    constant speed_of_wave : integer := 343;
    
    signal sig_distance : unsigned(15 downto 0) := (others => '0');
    signal sig_distance_ready : std_logic := '0';

begin

    process(clk)
    begin
    
        if(rising_edge(clk)) then
        
            if(rst = '1') then
            
                sig_distance <= (others => '0');
                sig_distance_ready <= '0';
                
            else
   
                sig_distance_ready <= '0';
                
                if(pulse_ready = '1') then
                
                    sig_distance <= resize((pulse_len * speed_of_wave / 2) / 1000, sig_distance'length);
                    sig_distance_ready <= '1';
                
                end if;
            
            end if;
        
        end if;
    
    end process;

    distance <= sig_distance;
    distance_ready <= sig_distance_ready;

end Behavioral;