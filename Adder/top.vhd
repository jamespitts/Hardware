----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:02:53 06/27/2020 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is
    port(
        lhs_led: out std_logic_vector(3 downto 0) := "0000";
        rhs_led: out std_logic_vector(3 downto 0) := "0000";
        result_led: out std_logic_vector(3 downto 0) := "0000"
    );
end top;

	    


architecture Behavioral of top is
    COMPONENT adder
	PORT(
		lhs : IN std_logic_vector(3 downto 0);
		rhs : IN std_logic_vector(3 downto 0);          
		result : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
    
    signal lhs: std_logic_vector(3 downto 0);
    signal rhs: std_logic_vector(3 downto 0);
    signal result: std_logic_vector(3 downto 0);
    
begin

	Inst_adder: adder PORT MAP(
		lhs => lhs,
		rhs => rhs,
		result => result
	);
    
    result_led <= result;
    lhs_led <= lhs;
    rhs_led <= rhs;

end Behavioral;

