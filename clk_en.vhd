library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_en is
    generic(
        n_periods : integer := 3
    );
    port(
        clk     :   in  std_logic;
        rst     :   in  std_logic;
        pulse   :   out std_logic
    );
end clk_en;

architecture Behavioral of clk_en is

    signal sig_count_clk : integer range 0 to n_periods - 1;

    begin

        proc_clk_en : process (clk) is
        
        begin

            if clk'event and clk = '1' then

                if(rst = '1') then
                    sig_count_clk <= 0;

                elsif(sig_count_clk < (n_periods - 1)) then
                    sig_count_clk <= sig_count_clk + 1;

                else
                    sig_count_clk <= 0;

                end if;

            end if;

        end process;

    pulse <= '1' when (sig_count_clk = n_periods - 1) 
            else '0';



end Behavioral;
