--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:22:04 07/09/2020
-- Design Name:   
-- Module Name:   /home/jim/Source/Hardware/Adder/adder_demo_testbench.vhd
-- Project Name:  Adder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adder_demo
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY adder_demo_testbench IS
END adder_demo_testbench;
 
ARCHITECTURE behavior OF adder_demo_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder_demo
    PORT(
         lhs : IN  std_logic_vector(3 downto 0);
         rhs : IN  std_logic_vector(3 downto 0);
         result : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal lhs : std_logic_vector(3 downto 0) := (others => '0');
   signal rhs : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(4 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder_demo PORT MAP (
          lhs => lhs,
          rhs => rhs,
          result => result
        );

  

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      
      lhs <= x"1";
      rhs <= x"0";
      wait for 200 ns;
      assert result = "00001";
   
   
      lhs <= x"1";
      rhs <= x"2";
      wait for 200 ns;
      assert result = "00011";
      
      wait;
   end process;

END;
