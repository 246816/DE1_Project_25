library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    
    port(
        -- HC-SR04 outputs
        JC0 : out std_logic;
        JC1 : out std_logic;
        JC2 : out std_logic;
        JC3 : out std_logic;

        -- HC-SR04 inputs
        JD0 : in std_logic;
        JD1 : in std_logic;
        JD2 : in std_logic;
        JD3 : in std_logic;

        -- Clock, dunno if others are needed
        CLK100MHz : in std_logic;
        BTNC : in std_logic;
        BTND : in std_logic;

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
    )


end top_level;

architecture Behavioral of top_level is

    component convertor is
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
                seg : in STD_LOGIC;
                data : in STD_LOGIC_VECTOR (3 downto 0);
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
        port ( 
            BTNC : in STD_LOGIC;
            BTND : in STD_LOGIC;
            CLK100MHz : in STD_LOGIC;
            clk_en_pulse : out STD_LOGIC
        );
    end component;

    signal sig_pulse : std_logic;
    signal sig_trigger : std_logic;

begin

    pulse_gen_init : clk_en
        port map(
            BTNC => BTNC,
            BTND => BTND,
            CLK100MHz => CLK100MHz,
            clk_en_pulse => 
        );


end Behavioral;
