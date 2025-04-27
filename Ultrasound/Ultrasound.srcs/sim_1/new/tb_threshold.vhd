library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_threshold is
end tb_threshold;

architecture tb of tb_threshold is

    component threshold
        port (distance : in unsigned (15 downto 0);
              LED      : out std_logic_vector (9 downto 0));
    end component;

    signal distance : unsigned (15 downto 0);
    signal LED      : std_logic_vector (9 downto 0);

begin

    dut : threshold
    port map (distance => distance,
              LED      => LED);

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        distance <= (others => '0');

        -- ***EDIT*** Add stimuli here

        -- Distance = 0 cm (should be all LEDs OFF)
        distance <= to_unsigned(0, distance'length);
        wait for 100 ns;

        -- Distance = 5 cm (still all LEDs OFF)
        distance <= to_unsigned(5, distance'length);
        wait for 100 ns;

        -- Distance = 10 cm (LED[0] ON)
        distance <= to_unsigned(10, distance'length);
        wait for 100 ns;

        -- Distance = 25 cm (LED[0] and LED[1] ON)
        distance <= to_unsigned(25, distance'length);
        wait for 100 ns;

        -- Distance = 55 cm (5 LEDs ON)
        distance <= to_unsigned(55, distance'length);
        wait for 100 ns;

        -- Distance = 99 cm (9 LEDs ON)
        distance <= to_unsigned(99, distance'length);
        wait for 100 ns;

        -- Distance = 160 cm (16 LEDs ON, capped)
        distance <= to_unsigned(160, distance'length);
        wait for 100 ns;

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_threshold of tb_threshold is
    for tb
    end for;
end cfg_tb_threshold;