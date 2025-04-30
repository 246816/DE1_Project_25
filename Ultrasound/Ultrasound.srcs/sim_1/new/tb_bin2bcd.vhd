library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_bin2bcd is
end tb_bin2bcd;

architecture tb of tb_bin2bcd is

    component bin2bcd
        port (clk            : in std_logic;
              rst            : in std_logic;
              distance       : in unsigned (15 downto 0);
              distance_ready : in std_logic;
              hundreds       : out unsigned (3 downto 0);
              tens           : out unsigned (3 downto 0);
              ones           : out unsigned (3 downto 0);
              bcd_ready      : out std_logic);
    end component;

    signal clk            : std_logic;
    signal rst            : std_logic;
    signal distance       : unsigned (15 downto 0);
    signal distance_ready : std_logic;
    signal hundreds       : unsigned (3 downto 0);
    signal tens           : unsigned (3 downto 0);
    signal ones           : unsigned (3 downto 0);
    signal bcd_ready      : std_logic;

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : bin2bcd
    port map (clk            => clk,
              rst            => rst,
              distance       => distance,
              distance_ready => distance_ready,
              hundreds       => hundreds,
              tens           => tens,
              ones           => ones,
              bcd_ready      => bcd_ready);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        distance <= (others => '0');
        distance_ready <= '0';

        -- Reset generation
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        -- Distance = 153 expected output hundreds - 1, tens - 5, ones - 3
        distance <= to_unsigned(153, 16);
        wait for 10 ns;
        distance_ready <= '1';
        wait for 10 ns;
        distance_ready <= '0';
        wait for 2 us;

        -- Distance = 85 expected output hundreds - 0, tens - 8, ones - 5
        distance <= to_unsigned(85, 16);
        wait for 10 ns;
        distance_ready <= '1';
        wait for 10 ns;
        distance_ready <= '0';
        wait for 2 us;

        -- Distance = 7 expected output hundreds - 0, tens - 0, ones 7
        distance <= to_unsigned(7, 16);
        wait for 10 ns;
        distance_ready <= '1';
        wait for 10 ns;
        distance_ready <= '0';
        wait for 2 us;

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_bin2bcd of tb_bin2bcd is
    for tb
    end for;
end cfg_tb_bin2bcd;