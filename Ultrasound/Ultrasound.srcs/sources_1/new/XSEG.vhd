library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- This entity handles the selection of which 7seg should show which number
-- Encapsulates bin2seg entity
-- Inputs are clock signal, reset signal and 4 bit numbers of hundreds, tens and ones 
--- from distance_calculation module
-- Outputs the catodes to be on (0) / off (1) and which anode digit should display number
entity xseg is

    port(
        clk : in std_logic;
        rst : in std_logic;
        
        -- Inputs 4bit binary number from bin2bcd module
        hundreds : in unsigned(3 downto 0);
        tens : in unsigned(3 downto 0);
        ones : in unsigned(3 downto 0);
        
        CA, CB, CC, CD, CE, CF, CG : out std_logic;
        AN : out std_logic_vector(2 downto 0);
        DP : out std_logic
    );

end xseg;

architecture Behavioral of xseg is

    signal sig_refresh_counter : unsigned(15 downto 0) := (others => '0');
    
    -- Internal signal for the selection of digits which is switched between 0 - 3
    signal sig_digit_select : unsigned(1 downto 0) := (others => '0');
    
    -- Internal signal for storing the binary value of the number
    signal sig_bin : unsigned(3 downto 0) := (others => '0');
    
    -- Internal signal for the catodes (CA, CB, CC, ..., CG)
    signal sig_seg : std_logic_vector(6 downto 0) := (others => '1');
    
    -- Creates component for bin2seg
    component bin2seg
        port(
            clear : in std_logic;
            bin : in unsigned(3 downto 0);
            seg : out std_logic_vector(6 downto 0)
        );
    end component;  
    
begin 

    -- Initializes the bin2seg component
    bin2seg_init : bin2seg
        port map(
            clear => '0',
            bin => sig_bin,
            seg => sig_seg
        );
        
    -- Process automatically runs when the clock signal is changed
    process(clk)
    begin
    
        if(rising_edge(clk)) then
        
            if(rst = '1') then
            
                sig_refresh_counter <= (others => '0');
                sig_digit_select <= (others => '0');
            
            else
                
                sig_refresh_counter <= sig_refresh_counter + 1;
                
                if(sig_refresh_counter = 0) then
                    
                    -- Increments the selected digit
                    sig_digit_select <= sig_digit_select + 1;
                    
                    -- When the selected digit is the last one reverts back to first one
                    if(sig_digit_select = 2) then
                    
                        sig_digit_select <= (others => '0');
                    
                    end if;
                
                end if;
            
            end if;
        
        end if;
    
    end process;    

    -- Process automatically runs when the internal signal for selected digit or value of hundreds, tens or ones is changed
    process(sig_digit_select, hundreds, tens, ones)
    begin
        
        -- Selects the proper digit and assigns value to it
        -- Digit 0 <= ones
        -- Digit 1 <= tens
        -- Digit 2 <= hundreds (unlikely to happen because of the maximum range)
        case sig_digit_select is
            
            when "00" =>
                sig_bin <= ones;
            when "01" =>
                sig_bin <= tens;
            when "10" =>
                sig_bin <= hundreds;
            
            -- On any other selected digit assign noting               
            when others =>
                sig_bin <= (others => '0');
            
        end case;
    
    end process;
    
    -- Deconstructs the internal seg signal into according catodes
    CA <= sig_seg(0);
    CB <= sig_seg(1);
    CC <= sig_seg(2);
    CD <= sig_seg(3);
    CE <= sig_seg(4);
    CF <= sig_seg(5);
    CG <= sig_seg(6);
    
    -- Process automatically runs when the internal selected digit signal is changed
    process(sig_digit_select)
    begin
    
        -- Selects the proper anode to be turned on
        -- 0 means the 7seg is on
        case sig_digit_select is
        
            -- Turn on the ones 7seg
            when "00" =>
                AN <= "110";
            when "01" =>
                AN <= "101";
            when "10" =>
                AN <= "011";
                
            -- On any other selected digit turn off all the digits          
            when others =>
                AN <= "111";
                          
        end case;
    
    end process;
    
    -- Hard wire the decimal to be off all the time
    DP <= '1';

end Behavioral;