library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_bin2seg is
end tb_bin2seg;

architecture tb of tb_bin2seg is

    component bin2seg
        port (clear : in std_logic;
              bin   : in unsigned (3 downto 0);
              seg   : out std_logic_vector (6 downto 0));
    end component;

    signal clear : std_logic;
    signal bin   : unsigned (3 downto 0);
    signal seg   : std_logic_vector (6 downto 0);

begin

    dut : bin2seg
    port map (clear => clear,
              bin   => bin,
              seg   => seg);

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        bin <= (others => '0');

        -- Reset generation
        clear <= '1';
        wait for 100 ns;
        clear <= '0';
        wait for 100 ns;

        -- ***EDIT*** Add stimuli here

        -- Loops through 0 - 15 and tries to show the number on the 7seg
        -- Should output correct numbers and from 10-15 should be 11111111 (all catodes are off)
        for i in 0 to 15 loop
            bin <= to_unsigned(i, 4);
            wait for 50 ns;
        end loop;

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_bin2seg of tb_bin2seg is
    for tb
    end for;
end cfg_tb_bin2seg;