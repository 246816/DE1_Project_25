----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2025 12:36:12 PM
-- Design Name: 
-- Module Name: threshold - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity threshold is
    Port ( dis : in STD_LOGIC_VECTOR (6 downto 0);
           LED : out STD_LOGIC_VECTOR (9 downto 0));
end threshold;

architecture Behavioral of threshold is

signal sig_dis : unsigned(6 downto 0);

begin

    -- Convert dis to unsigned type
    sig_dis <= unsigned(dis);

    process(sig_dis)
    begin
        -- Reset all LEDs
        LED <= (others => '0');

        -- Assign LEDs based on the value of sig_dis
        if (sig_dis >= 0 and sig_dis <= 10) then
            LED(0) <= '1';
        elsif (sig_dis >= 11 and sig_dis <= 20) then
            LED(1) <= '1';
        elsif (sig_dis >= 21 and sig_dis <= 30) then
            LED(2) <= '1';
        elsif (sig_dis >= 31 and sig_dis <= 40) then
            LED(3) <= '1';
        elsif (sig_dis >= 41 and sig_dis <= 50) then
            LED(4) <= '1';  
        elsif (sig_dis >= 51 and sig_dis <= 60) then
            LED(5) <= '1';
        elsif (sig_dis >= 61 and sig_dis <= 70) then
            LED(6) <= '1';
        elsif (sig_dis >= 71 and sig_dis <= 80) then
            LED(7) <= '1';
        elsif (sig_dis >= 81 and sig_dis <= 90) then
            LED(8) <= '1';
        elsif (sig_dis >= 91 and sig_dis <= 100) then
            LED(9) <= '1';
        else
            LED <= (others => '0');
        end if;
    end process;


end Behavioral;
