----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:14:13 07/09/2020 
-- Design Name: 
-- Module Name:    adder_demo - Behavioral 
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

entity adder_demo is
port (lhs: in std_logic_vector (3 downto 0) := x"0";
      rhs: in std_logic_vector (3 downto 0) := x"0";
      result: out std_logic_vector(4 downto 0)
);
end adder_demo;

architecture Behavioral of adder_demo is
   signal carry: std_logic_vector(3 downto 0) := x"0";
   signal sum: std_logic_vector(4 downto 0) := "00000";
begin

   half_adder: process(lhs, rhs)
   begin
      sum(0) <= lhs(0) xor rhs(0);
      carry(0) <= lhs(0) and rhs(0);
   end process;
   
   full_adder: process(lhs, rhs)
   begin
      sum(1) <= carry(0) xor (lhs(1) xor rhs(1));
      carry(1) <= (carry(0) and (lhs(1) xor rhs(1))) or (lhs(1) and rhs(1));
      
      sum(2) <= carry(1) xor (lhs(2) xor rhs(2));
      carry(2) <= (carry(1) and (lhs(2) xor rhs(2))) or (lhs(2) and rhs(2));

      sum(3) <= carry(2) xor (lhs(3) xor rhs(3));
      sum(4) <= (carry(2) and (lhs(3) xor rhs(3))) or (lhs(3) and rhs(3));     
   end process;

   result <= sum;

end Behavioral;

