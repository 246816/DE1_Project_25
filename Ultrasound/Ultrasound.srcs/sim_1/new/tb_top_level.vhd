library ieee;
use ieee.std_logic_1164.all;

entity tb_top_level is
end tb_top_level;

architecture tb of tb_top_level is

    component top_level
        port (CLK100MHZ : in std_logic;
              BTNC      : in std_logic;
              JA        : out std_logic_vector (4 downto 1);
              JB        : in std_logic_vector (4 downto 1);
              CA        : out std_logic;
              CB        : out std_logic;
              CC        : out std_logic;
              CD        : out std_logic;
              CE        : out std_logic;
              CF        : out std_logic;
              CG        : out std_logic;
              AN        : out std_logic_vector (2 downto 0);
              DP        : out std_logic;
              LED       : out std_logic_vector (9 downto 0));
    end component;

    signal CLK100MHZ : std_logic;
    signal BTNC      : std_logic;
    signal JA        : std_logic_vector (4 downto 1);
    signal JB        : std_logic_vector (4 downto 1);
    signal CA        : std_logic;
    signal CB        : std_logic;
    signal CC        : std_logic;
    signal CD        : std_logic;
    signal CE        : std_logic;
    signal CF        : std_logic;
    signal CG        : std_logic;
    signal AN        : std_logic_vector (2 downto 0);
    signal DP        : std_logic;
    signal LED       : std_logic_vector (9 downto 0);

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : top_level
    port map (CLK100MHZ => CLK100MHZ,
              BTNC      => BTNC,
              JA        => JA,
              JB        => JB,
              CA        => CA,
              CB        => CB,
              CC        => CC,
              CD        => CD,
              CE        => CE,
              CF        => CF,
              CG        => CG,
              AN        => AN,
              DP        => DP,
              LED       => LED);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that CLK100MHZ is really your main clock signal
    CLK100MHZ <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        BTNC <= '0';
        JB <= (others => '0');

        -- Reset generation
        BTNC <= '1';
        wait for 100 ns;
        BTNC<= '0';
        wait for 100 ns;

        wait for 2ms;
        
        -- Signal should be ~85cm so 8 LEDs are on
        JB(1) <= '1';
        wait for 500 us;
        JB(1) <= '0';
        wait for 3ms;
        
        -- Signal should be ~34cm so 3 LEDs are on;
        JB(1) <= '1';
        wait for 200 us;
        JB(1) <= '0';
        wait for 3ms;
        
        -- Signal shoud be ~17cm so 1 LED is on;
        JB(1) <= '1';
        wait for 100 us;
        JB(1) <= '0';
        wait for 3ms;

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_top_level of tb_top_level is
    for tb
    end for;
end cfg_tb_top_level;