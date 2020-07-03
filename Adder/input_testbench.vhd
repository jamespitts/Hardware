
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY input_testbench IS
END input_testbench;
 
ARCHITECTURE behavior OF input_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT input
    PORT(button_lo : IN  std_logic;
         button_hi : IN  std_logic;
         value : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal BUTTON_LO : std_logic := '0';
   signal BUTTON_HI : std_logic := '0';

 	--Outputs
   signal value : std_logic_vector(3 downto 0);
   signal clk: std_logic := '0';
   
BEGIN

   clk_process :process(clk)
   begin
		clk <= not clk after 5 ns;
   end process;
 
   uut: input PORT MAP (
          BUTTON_LO => BUTTON_LO,
          BUTTON_HI => BUTTON_HI,
          value => value
        );

   stim_proc: process
   begin		
      button_lo <= '0';
      button_hi <= '0';
      wait for 53 ns;	
      
      button_hi <= '1';
      wait for 27 ns;
      button_hi <= '0';
      wait for 27 ns;
      
      button_lo <= '1';
      wait for 27 ns;
      button_lo <= '0';
      wait for 27 ns;
      
      button_hi <= '1';
      wait for 27 ns;
      button_hi <= '0';
      wait for 27 ns;
      
     
      wait;
   end process;

END;
