library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity XSEG is
    Port (  clk : in STD_LOGIC;
            rst : in std_logic;
            data : in STD_LOGIC_VECTOR (7 downto 0);
            CA : out STD_LOGIC;
            CB : out STD_LOGIC;
            CC : out STD_LOGIC;
            CD : out STD_LOGIC;
            CE : out STD_LOGIC;
            CF : out STD_LOGIC;
            CG : out STD_LOGIC;
            AN : out std_logic_vector (7 downto 0);
            DP : out STD_LOGIC
        );
end XSEG;

architecture Behavioral of XSEG is

    component bin2seg is
        port (
            clear   : in    std_logic;
            bin     : in    std_logic_vector(7 downto 0);
            seg     : out   std_logic_vector(6 downto 0)
        );
    end component bin2seg;

    type state_type is (idle, handling_data, display_seg);

    type state_seg_number is (one, two, three);

    signal state        : state_type;

    signal sig_seg_number_switcher : state_seg_number;

    -- Might be dynamically assigned
    signal sig_input_number : integer range 0 to 100;

    signal sig_segment_1_show : std_logic_vector(7 downto 0);
    signal sig_segment_1_number : integer range 0 to 9;

    signal sig_segment_2_show : std_logic_vector(7 downto 0);
    signal sig_segment_2_number : integer range 0 to 9;
    
    signal sig_segment_3_show : std_logic_vector(7 downto 0);
    signal sig_segment_3_number : integer range 0 to 9;

    begin

        seg1 : component bin2seg 
            port map (
                clear => rst, 
                bin => sig_segment_1_show, 
                seg(0) => CA,
                seg(1) => CB,
                seg(2) => CC,
                seg(3) => CD,
                seg(4) => CE,
                seg(5) => CF,
                seg(6) => CG
            );
        seg2 : component bin2seg
             port map (
                clear => rst, 
                bin => sig_segment_2_show, 
                seg(0) => CA,
                seg(1) => CB,
                seg(2) => CC,
                seg(3) => CD,
                seg(4) => CE,
                seg(5) => CF,
                seg(6) => CG
            );
        seg3 : component bin2seg
             port map (
                clear => rst, 
                bin => sig_segment_3_show, 
                seg(0) => CA,
                seg(1) => CB,
                seg(2) => CC,
                seg(3) => CD,
                seg(4) => CE,
                seg(5) => CF,
                seg(6) => CG
            );
            
         prc: process(clk) is
         
         begin
        
        if clk'event and clk = '1' then

            AN <= "11111111";

            sig_segment_1_number <= to_integer(unsigned(data)) mod 10;
            sig_segment_2_number <= to_integer(unsigned(data)) / 10 mod 10;
            sig_segment_3_number <= to_integer(unsigned(data)) / 100 mod 10;

            if(rst = '1') then

                sig_segment_1_show <= "11111111";
                sig_segment_2_show <= "11111111";
                sig_segment_3_show <= "11111111";

            end if;

            case sig_seg_number_switcher is

                when one => 
                    -- TODO Not sure about the 7 might be 6
                    sig_segment_1_show <= std_logic_vector(to_unsigned(sig_segment_1_number, 8));
                    AN(0) <= '0';
                    sig_seg_number_switcher <= two;

                when two => 
                    sig_segment_2_show <= std_logic_vector(to_unsigned(sig_segment_2_number, 8));
                    AN(1) <= '0';
                    sig_seg_number_switcher <= three;

                when three => 
                    sig_segment_3_show <= std_logic_vector(to_unsigned(sig_segment_3_number, 8));
                    AN(2) <= '0';
                    sig_seg_number_switcher <= one;

                when others => null;
            end case;

        end if;

        end process;

end Behavioral;