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
begin
    p_7seg_decoder : process (bin,clear) is
    begin

        if (clear = '1') then
            seg <= "1111111";
        else
            
            case bin is

                when x"0" =>
                    seg <= "0000001";

                when x"1" =>
                    seg <= "1001111";

                when x"2" =>
                    seg <= "0010010";

                when x"3" =>
                    seg <= "0000110";

                when x"4" =>
                    seg <= "1001100";

                when x"5" =>
                    seg <= "0100100";

                when x"6" =>
                    seg <= "0100000";

                when x"7" =>
                    seg <= "0001111";

                when x"8" =>
                    seg <= "0000000";

                when x"9" =>
                    seg <= "0000100";
                when others =>
                    seg <= "0111000";

            end case;

        end if;

    end process p_7seg_decoder;

end architecture behavioral;