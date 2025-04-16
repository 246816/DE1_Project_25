-- Changes :
-- - Reduced segments only to 0 - 9 because there is no point for a - e

library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------

entity bin2seg is
    port (
        clear   : in    std_logic;
        bin     : in    std_logic_vector(6 downto 0);
        seg     : out   std_logic_vector(6 downto 0)
    );
end entity bin2seg;

-------------------------------------------------

architecture behavioral of bin2seg is

    constant show_0     : std_logic_vector(6 downto 0) := "0000001";
    constant show_1     : std_logic_vector(6 downto 0) := "1001111";
    constant show_2     : std_logic_vector(6 downto 0) := "0010010";
    constant show_3     : std_logic_vector(6 downto 0) := "0000110";
    constant show_4     : std_logic_vector(6 downto 0) := "1001100";
    constant show_5     : std_logic_vector(6 downto 0) := "0100100";
    constant show_6     : std_logic_vector(6 downto 0) := "0100000";
    constant show_7     : std_logic_vector(6 downto 0) := "0001111";
    constant show_8     : std_logic_vector(6 downto 0) := "0000000";
    constant show_9     : std_logic_vector(6 downto 0) := "0000100";
    constant show_rst   : std_logic_vector(6 downto 0) := "1111111";

begin
    p_7seg_decoder : process (bin, clear) is
    begin

        if (clear = '1') then
            seg <= show_rst;
        else
            
            case bin is

                when "0000000" => seg <= show_0;
                when "0000001" => seg <= show_1;
                when "0000010" => seg <= show_2;
                when "0000011" => seg <= show_3;
                when "0000100" => seg <= show_4;
                when "0000101" => seg <= show_5;
                when "0000110" => seg <= show_6;
                when "0000111" => seg <= show_7;
                when "0001000" => seg <= show_8;
                when "0001001" => seg <= show_9;
                when others => seg <= show_rst;

            end case;

        end if;

    end process p_7seg_decoder;

end architecture behavioral;