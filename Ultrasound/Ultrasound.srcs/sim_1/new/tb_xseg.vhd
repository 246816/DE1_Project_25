library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_xseg is
end tb_xseg;

architecture tb of tb_xseg is

    component xseg
        port (clk      : in std_logic;
              rst      : in std_logic;
              hundreds : in unsigned (3 downto 0);
              tens     : in unsigned (3 downto 0);
              ones     : in unsigned (3 downto 0);
              CA       : out std_logic;
              CB       : out std_logic;
              CC       : out std_logic;
              CD       : out std_logic;
              CE       : out std_logic;
              CF       : out std_logic;
              CG       : out std_logic;
              AN       : out std_logic_vector (2 downto 0);
              DP       : out std_logic);
    end component;

    signal clk      : std_logic;
    signal rst      : std_logic;
    signal hundreds : unsigned (3 downto 0);
    signal tens     : unsigned (3 downto 0);
    signal ones     : unsigned (3 downto 0);
    signal CA       : std_logic;
    signal CB       : std_logic;
    signal CC       : std_logic;
    signal CD       : std_logic;
    signal CE       : std_logic;
    signal CF       : std_logic;
    signal CG       : std_logic;
    signal AN       : std_logic_vector (2 downto 0);
    signal DP       : std_logic;

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : xseg
    port map (clk      => clk,
              rst      => rst,
              hundreds => hundreds,
              tens     => tens,
              ones     => ones,
              CA       => CA,
              CB       => CB,
              CC       => CC,
              CD       => CD,
              CE       => CE,
              CF       => CF,
              CG       => CG,
              AN       => AN,
              DP       => DP);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        hundreds <= (others => '0');
        tens <= (others => '0');
        ones <= (others => '0');

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        -- Set test digits: 7-5-3
        hundreds <= "0111"; -- 7
        tens     <= "0101"; -- 5
        ones     <= "0011"; -- 3

        -- Run for a while to see mux switching between digits
        wait for 5 ms;

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_xseg of tb_xseg is
    for tb
    end for;
end cfg_tb_xseg;