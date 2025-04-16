library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity trigger_gen is
    Port (
        clk   : in  STD_LOGIC;
        trig  : out STD_LOGIC
    );
end trigger_gen;

architecture Behavioral of trigger_gen is
    constant TRIG_INTERVAL : integer := 6000000;  -- 60ms @ 100MHz
    constant PULSE_WIDTH   : integer := 1000;     -- 10µs @ 100MHz

    signal counter : integer := 0;
begin
    process(clk)
    begin
        if clk'event and clk = '1' then
            if counter < PULSE_WIDTH then
                trig <= '1';
            else
                trig <= '0';
            end if;

            if counter < TRIG_INTERVAL then
                counter <= counter + 1;
            else
                counter <= 0;
            end if;
        end if;
    end process;
end Behavioral;
