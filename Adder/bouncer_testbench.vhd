--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:45:33 07/02/2020
-- Design Name:   
-- Module Name:   /home/jim/Source/Hardware/Adder/bouncer_testbench.vhd
-- Project Name:  Adder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: debounce
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
 
ENTITY bouncer_testbench IS
END bouncer_testbench;
 
ARCHITECTURE behavior OF bouncer_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT debounce
    PORT(
         clk : IN  std_logic;
         signal_in : IN  std_logic;
         signal_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal signal_in : std_logic := '0';

 	--Outputs
   signal signal_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: debounce PORT MAP (
          clk => clk,
          signal_in => signal_in,
          signal_out => signal_out
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
      wait until rising_edge(clk);
      signal_in <= '0';
      wait until rising_edge(clk);
        
      -- button pressed
      signal_in <= '1';
      wait for clk_period * 5;
      assert signal_out = '1';
      
      wait until rising_edge(clk);
      -- release
      signal_in <= '0';
      wait for clk_period * 5;
      assert signal_out = '0';
      
      wait until rising_edge(clk);
      
      signal_in <= '1';
      wait for 1 ns;
      signal_in <= '0';
      wait for 1 ns;
      signal_in <= '1';
      wait for 1 ns;
      signal_in <= '0';
      wait for 1 ns;
      signal_in <= '1';
      wait for 1 ns;
      signal_in <= '0';
      wait for 1 ns;
   
      wait;
   end process;

END;
