----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:06:52 05/02/2020 
-- Design Name: 
-- Module Name:    drive5v - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity drive5v is
    Port ( drive5v : inout  STD_LOGIC;
    LED_1 : out std_logic := '0';
    LED_2 : out std_logic := '0';
    EXT_LED_1 : out std_logic := '0';
    BUTTON : in std_logic := '0');
end drive5v;

architecture Behavioral of drive5v is

begin
 LED_1 <= BUTTON;
 LED_2 <= NOT BUTTON;
 EXT_LED_1 <= '1';
 drive5v <= 'Z' when (BUTTON='1') else '0';
end Behavioral;

