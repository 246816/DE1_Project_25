library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XSEG is
    Port (  clk : in STD_LOGIC;
            rst : in std_logic;
            seg : in STD_LOGIC;
            CA : out STD_LOGIC;
            CB : out STD_LOGIC;
            CC : out STD_LOGIC;
            CD : out STD_LOGIC;
            CE : out STD_LOGIC;
            CF : out STD_LOGIC;
            CG : out STD_LOGIC;
            AN : out STD_LOGIC;
            DP : out STD_LOGIC
        );
end XSEG;

architecture Behavioral of XSEG is

    type state_type is (idle, handling_data, display_seg);

    signal state        : state_type;

    constant show_0     : std_logic_vector(6 downto 0) := "1000000";
    constant show_1     : std_logic_vector(6 downto 0) := "1111001";
    constant show_2     : std_logic_vector(6 downto 0) := "0100100";
    constant show_3     : std_logic_vector(6 downto 0) := "0110000";
    constant show_4     : std_logic_vector(6 downto 0) := "0011001";
    constant show_5     : std_logic_vector(6 downto 0) := "0010010";
    constant show_6     : std_logic_vector(6 downto 0) := "0000010";
    constant show_7     : std_logic_vector(6 downto 0) := "1111000";
    constant show_8     : std_logic_vector(6 downto 0) := "0000000";
    constant show_9     : std_logic_vector(6 downto 0) := "0011000";
    constant show_rst   : std_logic_vector(6 downto 0) := "0000000";

    signal sig_show_seg_1 : std_logic_vector(6 downto 0);
    signal sig_show_seg_2 : std_logic_vector(6 downto 0);
    signal sig_show_seg_3 : std_logic_vector(6 downto 0);

    begin

        if clk'event and clk = '1' then

            if(rst = '1') then

                sig_show_seg_1 <= (others => '0');
                sig_show_seg_2 <= (others => '0');
                sig_show_seg_3 <= (others => '0');

                

            end if;



        end if;



end Behavioral;
