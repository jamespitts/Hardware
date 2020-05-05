-------------------------------------------------------------------------------- 
-- Company:  
-- Engineer: 
-- 
-- Create Date:    08/02/06 
-- Design Name:     
-- Module Name:    top 
-- Project Name:    
-- Target Device:   
-- Tool versions:   
-- Description: 
-- 
-- Dependencies: 
--  
-- Revision 0.01 - File Created by Scott S. 
-- Additional Comments: 
--  
-------------------------------------------------------------------------------- 
 
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
 
---- Uncomment the following library declaration if instantiating 
---- any Xilinx primitives in this code. 
--library UNISIM; 
--use UNISIM.VComponents.all; 
 
entity top is 
	Port	(  
	 		m0 				: in std_logic; 
	 		m1 				: in std_logic; 
	 		m2 				: in std_logic; 
         	DONE 			: in std_logic; 
         	XCF_CE_B		: out std_logic;  --XCF_CE_B is the Chip Enable for the Platform Flash 
           	A	 			: out std_logic_vector(24 downto 20)); 
end top; 
 
 
architecture Behavioral of top is 
 
signal mode_done : std_logic_vector(3 downto 0); -- signal to combine M0,1,2 and DONE 
 
begin 
 
XCF_CE_B <= (m0 or m1 or m2);  --"Or Gate" to dissable Platform Flash when not in MS mode 
mode_done <= (m0, m1, m2, DONE); -- combines M0,1,2 and DONE 
 
process(mode_done) -- Process to assign A20-A24 0's during BPI up, 1's down, tristate when DONE 
	begin 
		case (mode_done) is 						 
      				when "0100" =>	  				        				 
							A	<= "00000"; --A20-A24 is all 0's when BPI Up Mode and DONE=0 
      				when "1100" =>	 		   	 
							A	<= "11111"; --A20-A24 is all 1's when BPI Down Mode and DONE=0 
      				when others => 
							A	<= "ZZZZZ"; -- Otherwise tristated 
		end case; 
end process; 
 
end Behavioral; 

