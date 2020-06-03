--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:25:49 05/28/2020
-- Design Name:   
-- Module Name:   /home/jim/Source/Hardware/z80_lifesupport/test_mcu.vhd
-- Project Name:  z80_lifesupport
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MCU
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
 
ENTITY test_mcu IS
END test_mcu;
 
ARCHITECTURE behavior OF test_mcu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MCU
    PORT(
        reset : IN std_logic;
		clk : IN std_logic;
        
        -- from z80
		rd : IN std_logic;
		m1 : IN std_logic;
		mreq : IN std_logic;
        hold: out std_logic;
		addr : IN std_logic_vector(15 downto 0);       
		data : INOUT std_logic_vector(7 downto 0);
        
        spi_addr: out std_logic_vector(1 downto 0);
        spi_data: inout std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal addr : std_logic_vector(3 downto 0) := (others => '0');
   
   signal rd : std_logic := '0';
   signal m1 : std_logic := '0';
   signal mreq : std_logic := '0';
   signal hold : std_logic := '0';
   
   signal spi_addr: std_logic_vector(1 downto 0) := "00";
   signal spi_data: std_logic_vector(7 downto 0) := "00000000";



	--BiDirs
   signal data : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 250 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MCU PORT MAP (
          reset => reset,
          clk => clk,
          rd => rd,
          m1 => m1,
          mreq => mreq,
          hold => hold,
          addr => addr,
          data => data,
          spi_addr => spi_addr,
          spi_data => spi_data
        );

   -- Clock process definitions
   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    --   clk <= not clk after clk_period/2 ns;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      reset<='0';
      m1 <='1';
      rd <= '1';
      mreq <= '1';
      addr <= "0000";

      wait for clk_period*3;
      reset<='1';      
      
      wait until rising_edge(clk);
      wait until rising_edge(clk);
      wait until rising_edge(clk);
       
      wait for clk_period/4;
      
      m1 <= '0';
      addr <= "1010";
      
      wait for clk_period/2;
      
      rd <='0';
      mreq <='0';   
      
      wait until hold = 'Z';
      wait until rising_edge(clk);
      wait for clk_period/4;

      m1 <='1';
      rd <='1';
      mreq <= '1';

      -- refresh <= '0';
      wait until rising_edge(clk);
      mreq <= '0';

      wait until rising_edge(clk);
      mreq <= '1';
      

      wait until rising_edge(clk);
      -- refresh <= '1';




      wait;
   end process;

END;
