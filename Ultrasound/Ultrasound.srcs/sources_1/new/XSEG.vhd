library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity xseg is

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

end xseg;

architecture Behavioral of xseg is

    signal sig_refresh_counter : unsigned(15 downto 0) := (others => '0');
    signal sig_digit_select : unsigned(1 downto 0) := (others => '0');
    signal sig_bin : unsigned(3 downto 0) := (others => '0');
    signal sig_seg : std_logic_vector(6 downto 0) := (others => '1');
    
    component bin2seg
        port(
            clear : in std_logic;
            bin : in unsigned(3 downto 0);
            seg : out std_logic_vector(6 downto 0)
        );
    end component;  
    
begin 

    bin2seg_init : bin2seg
        port map(
            clear => '0',
            bin => sig_bin,
            seg => sig_seg
        );
        
    process(clk)
    begin
    
        if(rising_edge(clk)) then
        
            if(rst = '1') then
            
                sig_refresh_counter <= (others => '0');
                sig_digit_select <= (others => '0');
            
            else
                
                sig_refresh_counter <= sig_refresh_counter + 1;
                
                if(sig_refresh_counter = 0) then
                
                    sig_digit_select <= sig_digit_select + 1;
                    
                    if(sig_digit_select = 2) then
                    
                        sig_digit_select <= (others => '0');
                    
                    end if;
                
                end if;
            
            end if;
        
        end if;
    
    end process;    

    process(sig_digit_select, hundreds, tens, ones)
    begin
    
        case sig_digit_select is
            
            when "00" =>
                sig_bin <= ones;
            when "01" =>
                sig_bin <= tens;
            when "10" =>
                sig_bin <= hundreds;
            when others =>
                sig_bin <= (others => '0');
            
        end case;
    
    end process;
    
    CA <= sig_seg(0);
    CB <= sig_seg(1);
    CC <= sig_seg(2);
    CD <= sig_seg(3);
    CE <= sig_seg(4);
    CF <= sig_seg(5);
    CG <= sig_seg(6);
    
    process(sig_digit_select)
    begin
    
        case sig_digit_select is
        
            when "00" =>
                AN <= "110";
            when "01" =>
                AN <= "101";
            when "10" =>
                AN <= "011";
            when others =>
                AN <= "111";
                          
        end case;
    
    end process;
    
    DP <= '1';

end Behavioral;