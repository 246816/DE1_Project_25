library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- This entity handles correct decoding of binary number to catodes on 7seg display
-- Inputs are clear signal which resets the segment and bin which is 4 bit binary number 
--- of the desired number to be shown on the 7seg
-- Outputs the 7 bit binary number of which catodes to be turned on (0) / off (1)
entity bin2seg is
    port (
        clear   : in    std_logic;
        -- 4 bit number from xseg module
        bin     : in    unsigned(3 downto 0);
        seg     : out   std_logic_vector(6 downto 0)
    );
end entity bin2seg;

architecture behavioral of bin2seg is

    -- Constants for easier and more clear work with the catodes
    -- 0 means the catode will be on and 1 means it will be turned off
    -- The catodes are then extracted in the xseg in (CA, CB, CC, ..., CG) order
    constant show_0 : std_logic_vector(6 downto 0) := "0000001";
    constant show_1 : std_logic_vector(6 downto 0) := "1001111";
    constant show_2 : std_logic_vector(6 downto 0) := "0010010";
    constant show_3 : std_logic_vector(6 downto 0) := "0000110";
    constant show_4 : std_logic_vector(6 downto 0) := "1001100";
    constant show_5 : std_logic_vector(6 downto 0) := "0100100";
    constant show_6 : std_logic_vector(6 downto 0) := "0100000";
    constant show_7 : std_logic_vector(6 downto 0) := "0001111";
    constant show_8 : std_logic_vector(6 downto 0) := "0000000";
    constant show_9 : std_logic_vector(6 downto 0) := "0000100";
    
    -- If there is more than 9 or the reset is 1 then there is nothing to display
    constant show_rst : std_logic_vector(6 downto 0) := "1111111";
    
begin
    -- Process automatically runs when the bin or clear is changed
    process (bin, clear) is
    begin
        -- On clear show nothing
        if (clear = '1') then
            seg <= show_rst;
        else
            
            -- On bin change
            case bin is
                
                -- Assign according value to seg from binary number
                when "0000" => seg <= show_0;
                when "0001" => seg <= show_1;
                when "0010" => seg <= show_2;
                when "0011" => seg <= show_3;
                when "0100" => seg <= show_4;
                when "0101" => seg <= show_5;
                when "0110" => seg <= show_6;
                when "0111" => seg <= show_7;
                when "1000" => seg <= show_8;
                when "1001" => seg <= show_9;
                
                -- On any other value assing nothing to the segment
                when others => seg <= show_rst;

            end case;

        end if;

    end process;

end architecture behavioral;