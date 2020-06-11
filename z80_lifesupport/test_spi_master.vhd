--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:27:51 06/04/2020
-- Design Name:   
-- Module Name:   /home/jim/Source/Hardware/z80_lifesupport/test_spi_master.vhd
-- Project Name:  z80_lifesupport
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: spi_master
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
 
ENTITY test_spi_master IS
END test_spi_master;
 
ARCHITECTURE behavior OF test_spi_master IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT spi_master
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         
         addr : IN  std_logic_vector(1 downto 0);
         data_in : IN  std_logic_vector(7 downto 0);
         data_out : OUT  std_logic_vector(7 downto 0);
         cs : in std_logic;
         done: out std_logic;
         
         spi_cs : OUT  std_logic;
         spi_mosi : OUT  std_logic;
         spi_miso : IN  std_logic;
         spi_clk : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal addr : std_logic_vector(1 downto 0) := (others => '0');
   signal data_in : std_logic_vector(7 downto 0);
   signal cs : std_logic := '0';
   signal spi_miso : std_logic := '0';


 	--Outputs
   signal spi_cs : std_logic;
   signal spi_mosi : std_logic;
   signal spi_clk : std_logic;
   
   signal data_out : std_logic_vector(7 downto 0);
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: spi_master PORT MAP (
          clk => clk,
          reset => reset,
          
          addr => addr,
          data_in => data_in,
          data_out => data_out,
          cs => cs,
          done => done,
          
          spi_cs => spi_cs,
          spi_mosi => spi_mosi,
          spi_miso => spi_miso,
          spi_clk => spi_clk
        );

   -- Clock process definitions
   clk_process :process(clk)
   begin
        clk <= (not clk) after clk_period/2;
   end process;
  
   -- Stimulus process
   stim_proc: process
   begin		
      reset <='0';
      wait for clk_period*3;
      reset<='1';      
      cs <= '0';
         
      wait until rising_edge(clk);
      
      addr <= "00";
      data_in <= x"9F";
      cs <= '1';
      
      wait until done = '1';
      cs <= '0';
      
      data_in <= x"00";
      report "all done";

      wait;
   end process;

END;
