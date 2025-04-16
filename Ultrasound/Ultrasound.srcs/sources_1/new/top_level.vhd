library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    
    port(
        -- Clock, dunno if others are needed
        CLK100MHz : in std_logic;
        
        echo : in std_logic;
        trig : out std_logic;
        
        BTNC : in std_logic;

        -- XSEG
        CA : out std_logic;
        CB : out std_logic;
        CC : out std_logic;
        CD : out std_logic;
        CE : out std_logic;
        CF : out std_logic;
        CG : out std_logic;
        AN : out std_logic_vector(7 downto 0);
        DP : out std_logic;

        -- LEDs
        LED : out std_logic_vector(9 downto 0)
    );


end top_level;

architecture Behavioral of top_level is

    signal distance_cm : std_logic_vector (7 downto 0);
    
    signal bcd_data : std_logic_vector (15 downto 0);
    
    signal digit_0 : std_logic_vector(3 downto 0);
    signal digit_1 : std_logic_vector(3 downto 0);
    signal digit_2 : std_logic_vector(3 downto 0);
    signal digit_3 : std_logic_vector(3 downto 0);
    
    
    component trigger_gen
        port(
            clk : in std_logic;
            trig : out std_logic
        );
    end component;
    
    component convertor is
        generic(
            MAX_DISTANCE_CM : integer := 100
        );
        port(
            echo            : in    std_logic;
            -- Not CLK100MHz but the pulses from clk_en
            clk             : in    std_logic;
            distance        : out   std_logic_vector(7 downto 0)
        );
    end component;

    component XSEG is
        port (  
                clk : in STD_LOGIC;
                rst : in std_logic;
                data : in STD_LOGIC_VECTOR (7 downto 0);
                CA : out STD_LOGIC;
                CB : out STD_LOGIC;
                CC : out STD_LOGIC;
                CD : out STD_LOGIC;
                CE : out STD_LOGIC;
                CF : out STD_LOGIC;
                CG : out STD_LOGIC;
                AN : out STD_LOGIC_VECTOR (7 downto 0);
                DP : out STD_LOGIC
            );
    end component;

    component threshold is
        port ( 
            dis : in STD_LOGIC_VECTOR (7 downto 0);
            LED : out STD_LOGIC_VECTOR (9 downto 0)
        );
    end component;

    component clk_en is
        generic(
            n_periods : integer := 3
        );
        port(
            clk     :   in  std_logic;
            rst     :   in  std_logic;
            pulse   :   out std_logic
        );
    end component;
    
    function to_bcd_convert(num : unsigned (7 downto 0)) return std_logic_vector is
        variable n: integer := to_integer(num);
        variable thousands, hundreds, tens, ones : integer;
        variable bcd : std_logic_vector (15 downto 0);
        variable d3, d2, d1, d0 : std_logic_vector(4 downto 0);
        begin
            thousands := n / 1000;
            n := n mod 1000;
            hundreds := n / 100;
            n := n mod 100;
            tens := n / 10;
            ones := n mod 10;
            
            d3 := std_logic_vector(to_unsigned(thousands, 4));
            d2 := std_logic_vector(to_unsigned(hundreds, 4));
            d1 := std_logic_vector(to_unsigned(tens, 4));
            d0 := std_logic_vector(to_unsigned(ones, 4));
            
            bcd := d3 & d2 & d1 & d0;
        return bcd;
    end function to_bcd_convert;

    signal sig_pulse : std_logic;
    signal sig_trigger : std_logic;
    
    signal clk_en_pulse : std_logic;
    
    signal sig_distance : std_logic_vector(7 downto 0);

begin

    trigger1 : trigger_gen
        port map(
            clk => CLK100MHz,
            trig => trig
        );

    counter1 : clk_en
        generic map(
            n_periods => 10
        )
        port map(
            rst => BTNC,
            clk => CLK100MHz,
            pulse => clk_en_pulse
        );

    convert1 : convertor
        port map(
            echo => clk_en_pulse,
            clk => CLK100MHz,
            distance => distance_cm
        );

    XSEG1 : XSEG
        port map(
            clk => CLK100MHz,
            rst => BTNC,
            data => sig_distance,
            CA => CA,
            CB => CB,
            CC => CC,
            CD => CD,
            CE => CE,
            CF => CF,
            CG => CG,
            AN => AN
        );

end Behavioral;