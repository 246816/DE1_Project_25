library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_echo_meas is
end tb_echo_meas;

architecture tb of tb_echo_meas is

    component echo_meas
        port (clk       : in std_logic;
              rst       : in std_logic;
              echo      : in std_logic;
              done      : out std_logic;
              pulse_len : out unsigned (20 downto 0));
    end component;

    signal clk       : std_logic;
    signal rst       : std_logic;
    signal echo      : std_logic;
    signal done      : std_logic;
    signal pulse_len : unsigned (20 downto 0);

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : echo_meas
    port map (clk       => clk,
              rst       => rst,
              echo      => echo,
              done      => done,
              pulse_len => pulse_len);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        echo <= '0';

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        -- Simulate an echo pulse: 1 ms pulse
        echo <= '1';
        wait for 1 ms;
        echo <= '0';

        -- Wait to see done signal
        wait for 500 us;

        -- Simulate a shorter echo pulse: 500 us pulse
        echo <= '1';
        wait for 500 us;
        echo <= '0';

        -- Wait to see done signal
        wait for 500 us;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_echo_meas of tb_echo_meas is
    for tb
    end for;
end cfg_tb_echo_meas;