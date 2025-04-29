library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_distance_calculation is
end tb_distance_calculation;

architecture tb of tb_distance_calculation is

    component distance_calculation
        port (clk            : in std_logic;
              rst            : in std_logic;
              pulse_len      : in unsigned (20 downto 0);
              pulse_ready    : in std_logic;
              distance       : out unsigned (15 downto 0);
              distance_ready : out std_logic);
    end component;

    signal clk            : std_logic;
    signal rst            : std_logic;
    signal pulse_len      : unsigned (20 downto 0);
    signal pulse_ready    : std_logic;
    signal distance       : unsigned (15 downto 0);
    signal distance_ready : std_logic;

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : distance_calculation
    port map (clk            => clk,
              rst            => rst,
              pulse_len      => pulse_len,
              pulse_ready    => pulse_ready,
              distance       => distance,
              distance_ready => distance_ready);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        pulse_len <= (others => '0');
        pulse_ready <= '0';

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

         -- Pulse_len = 100000 expected ~171cm
        pulse_len <= to_unsigned(100000, pulse_len'length);
        pulse_ready <= '1';
        wait for 10 ns;
        pulse_ready <= '0';

        -- Wait some time to process
        wait for 200 ns;

        -- Pulse_len = 50000 expected ~85cm
        pulse_len <= to_unsigned(50000, pulse_len'length);
        pulse_ready <= '1';
        wait for 10 ns;
        pulse_ready <= '0';

        -- Wait
        wait for 200 ns;

        -- Pulse_len = 10000 expected ~11cm
        pulse_len <= to_unsigned(10000, pulse_len'length);
        pulse_ready <= '1';
        wait for 10 ns;
        pulse_ready <= '0';

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_distance_calculation of tb_distance_calculation is
    for tb
    end for;
end cfg_tb_distance_calculation;