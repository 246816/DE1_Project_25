library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- This entity converts the input distance into 3 segments of hundreds, tens and ones 
-- 173 will be decoded as 1 -> hundreds, 7 -> tens, 3 -> ones
-- Inputs are clock signal, reset signal and distance in cm with signal of ended calculation
-- Outputs are three 4bit digits of the decoded distance with bcd ready signal of ended conversion
entity bin2bcd is
    
    port(
        clk : in std_logic;
        rst : in std_logic;
        -- Distance in cm from distance_calculation module
        distance : in unsigned(15 downto 0);
        distance_ready : in std_logic;
        hundreds : out unsigned(3 downto 0);
        tens : out unsigned(3 downto 0);
        ones : out unsigned(3 downto 0);
        bcd_ready : out std_logic
    );
    
end bin2bcd;

-- Sources
    -- https://piembsystech.com/binary-to-bcd-conversion-in-vhdl-programming-language/
    -- https://en.wikipedia.org/wiki/Double_dabble
    -- https://joulsen.dk/posts/double-dabble/
architecture Behavioral of bin2bcd is

    -- 27 = 16 for distance + 4*3 for hundreds, tens, ones
    signal sig_shift_reg : unsigned(27 downto 0) := (others => '0');
    signal sig_bit_count : unsigned(7 downto 0) := (others => '0');
    signal sig_working : std_logic := '0';
    
begin

    -- Extracts the correct bits from large shift register
    hundreds <= sig_shift_reg(27 downto 24);
    tens <= sig_shift_reg(23 downto 20);
    ones <= sig_shift_reg(19 downto 16);
    bcd_ready <= '1' when sig_bit_count = 17 else '0';

    -- Process automatically runs when the clk is changed
    process(clk)
        
        -- Create another temporary shift variable of the same size as internal shift register
        -- Had to be done because of an error of changing value before saving
        variable temp_shift : unsigned(27 downto 0);
    
    begin
    
        if(rising_edge(clk)) then
        
            if(rst = '1') then
                
                -- Resets all internal signals
                sig_shift_reg <= (others => '0');
                sig_bit_count <= (others => '0');
                sig_working <= '0';
            
            else
               
                -- Once the distance_calculation is done
                if(distance_ready = '1') then 
                
                    -- Clears shift register
                    sig_shift_reg(27 downto 15) <= (others => '0');
                    -- Uploads the distance into the lower 15 bits of shift register
                    sig_shift_reg(15 downto 0) <= distance;
                    sig_bit_count <= (others => '0');
                    sig_working <= '1';
               
                elsif sig_working = '1' then
               
                    -- Until the bit count signal is lower than 16 update shift the registers
                    if sig_bit_count < 16 then
                        
                        -- Stores the shift register into temp variable
                        temp_shift := sig_shift_reg;
                    
                        -- Double dabble function seek sources
                        if(temp_shift(27 downto 24) > 4) then
                        
                            temp_shift(27 downto 24) := temp_shift(27 downto 24) + 3;
                        
                        end if;
                        
                        if(temp_shift(23 downto 20) > 4) then
                        
                            temp_shift(23 downto 20) := temp_shift(23 downto 20) + 3;
                        
                        end if;
                        
                        if(temp_shift(19 downto 16) > 4) then
                        
                            temp_shift(19 downto 16) := temp_shift(19 downto 16) + 3;
                        
                        end if;
                        
                        -- Shifts temporary shift register by one bit to the right
                        temp_shift := temp_shift(26 downto 0) & '0';
                        
                        -- Passes temporary value to internal signal
                        sig_shift_reg <= temp_shift;
                        sig_bit_count <= sig_bit_count + 1;
                        
                    else
                    
                        sig_working <= '0';
                       
                    end if;
               
                end if;
            
            end if;
        
        end if;
    
    end process;

end Behavioral;
