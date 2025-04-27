library ieee;
use ieee.std_logic_1164.all;

entity tb_top_level is
end tb_top_level;

architecture tb of tb_top_level is

    component top_level
        port (CLK100MHz : in std_logic;
              BTNC      : in std_logic;
              JA        : inout std_logic_vector (4 downto 1);
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

    signal CLK100MHz : std_logic;
    signal BTNC      : std_logic;
    signal JA        : std_logic_vector (4 downto 1) := (others => 'Z');
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

    signal JA_driver : std_logic_vector(4 downto 1) := (others => 'Z');

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : top_level
    port map (CLK100MHz => CLK100MHz,
              BTNC      => BTNC,
              JA        => JA_driver,
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

    -- ***EDIT*** Check that CLK100MHz is really your main clock signal
    CLK100MHz <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        BTNC <= '0';

        -- Reset generation
        --  ***EDIT*** Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        BTNC <= '1';
        wait for 100 ns;
        BTNC <= '0';
        wait for 100 ns;
        
        JA(4) <= '0';
        JA(1) <= '0';
        JA(2) <= '0';
        JA(3) <= '0';
        
        wait for 20 ns;
        
        JA_driver(1) <= '0';

        wait for 20 ns;

        -- Simulate echo pulse (simulate object at 50 cm distance approx.)
        -- (Simplified timing just for testing pulse)
        JA(2) <= '0'; -- Echo low
        wait for 1 ms;
        JA(2) <= '1'; -- Echo goes high (object detected)
        wait for 750 us; -- Hold echo high (simulate measured distance)
        JA(2) <= '0'; -- Echo low again

        -- Wait and watch results
        wait for 5 ms;

        -- Second echo pulse (closer object)
        JA(2) <= '1';
        wait for 250 us;
        JA(2) <= '0';

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