library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
    
    port(
        CLK100MHZ : in std_logic;
        BTNC: in std_logic;
        JA : inout std_logic_vector(4 downto 1);
        CA, CB, CC, CD, CE, CF, CG : out std_logic;
        AN : out std_logic_vector(2 downto 0);
        DP : out std_logic;
        LED : out std_logic_vector(9 downto 0)
    );

end top_level;

architecture Behavioral of top_level is

    signal clk : std_logic;
    signal rst : std_logic;
    signal echo : std_logic;
    signal trig : std_logic;

    signal sig_pulse_len : unsigned(20 downto 0);
    signal sig_done : std_logic;
    
    signal sig_distance : unsigned(15 downto 0);
    signal sig_distance_ready : std_logic;
    
    signal sig_hundreds : unsigned(3 downto 0);
    signal sig_tens : unsigned(3 downto 0);
    signal sig_ones : unsigned(3 downto 0);
    signal sig_bcd_ready : std_logic;

    component trigger_generator
        
        port(
            clk : in std_logic;
            rst : in std_logic;
            trig : out std_logic
        );
        
    end component;
    
    component echo_meas
    
        port(
            clk : in std_logic;
            rst : in std_logic;
            echo : in std_logic;
            done : out std_logic;
            pulse_len : out unsigned(20 downto 0)
        );
    
    end component;
    
    component distance_calculation
    
        port(
            clk : in std_logic;
            rst : in std_logic;
            pulse_len : in unsigned(20 downto 0);
            pulse_ready : in std_logic;
            distance : out unsigned(15 downto 0);
            distance_ready : out std_logic
        );
    
    end component;
    
    component threshold 
    
        port ( 
            distance : in unsigned(15 downto 0);
            LED : out std_logic_vector(9 downto 0)
        );
    
    end component;

    component bin2bcd
    
        port(
            clk : in std_logic;
            rst : in std_logic;
            distance : in unsigned(15 downto 0);
            distance_ready : in std_logic;
            hundreds : out unsigned(3 downto 0);
            tens : out unsigned(3 downto 0);
            ones : out unsigned(3 downto 0);
            bcd_ready : out std_logic
        );
    
    end component;

    component xseg
    
        port(
            clk : in std_logic;
            rst : in std_logic;
            hundreds : in unsigned(3 downto 0);
            tens : in unsigned(3 downto 0);
            ones : in unsigned(3 downto 0);
            CA, CB, CC, CD, CE, CF, CG : out std_logic;
            AN : out std_logic_vector(2 downto 0);
            DP : out std_logic
        );
    
    end component;

begin

    clk <= CLK100MHZ;
    rst <= BTNC;
    trig <= JA(1);
    echo <= JA(2);
    
    JA(1) <= trig;

    trigger_generator_init : trigger_generator
        port map(
            clk => clk,
            rst => rst,
            trig => trig
        );

    echo_meas_init : echo_meas
        port map(
            clk => clk,
            rst => rst,
            echo => echo,
            done => sig_done,
            pulse_len => sig_pulse_len
        );
        
    distance_calculation_init : distance_calculation
        port map(
            clk => clk,
            rst => rst,
            pulse_len => sig_pulse_len,
            pulse_ready => sig_done,
            distance => sig_distance,
            distance_ready => sig_distance_ready
        );
        
    bin2bcd_init : bin2bcd
        port map(
            clk => clk,
            rst => rst,
            distance => sig_distance,
            distance_ready => sig_distance_ready,
            hundreds => sig_hundreds,
            tens => sig_tens,
            ones => sig_ones,
            bcd_ready => sig_bcd_ready
        ); 
        
    xseg_init : xseg
        port map(
            clk => clk,
            rst => rst,
            hundreds => sig_hundreds,
            tens => sig_tens,
            ones => sig_ones,
            CA => CA,
            CB => CB,
            CC => CC,
            CD => CD,
            CE => CE,
            CF => CF,
            CG => CG,
            AN => AN,
            DP => DP
        ); 
       
    threshold_init : threshold
        port map(
            distance => sig_distance,
            LED => LED
        );

end Behavioral;