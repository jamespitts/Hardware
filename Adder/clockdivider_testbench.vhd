--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:25:28 07/05/2020
-- Design Name:   
-- Module Name:   /home/jim/Source/Hardware/Adder/clockdivider_testbench.vhd
-- Project Name:  Adder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: clockdivider
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
 
ENTITY clockdivider_testbench IS
END clockdivider_testbench;
 
ARCHITECTURE behavior OF clockdivider_testbench IS 
 
 
    COMPONENT clockdivider
    PORT(
         clk : IN  std_logic;
         clk_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal clk_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns; 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clockdivider PORT MAP (
          clk => clk,
          clk_out => clk_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*100;

      -- insert stimulus here 

      wait;
   end process;

END;
