
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY adder_testbench IS
END adder_testbench;
 
ARCHITECTURE behavior OF adder_testbench IS 
 
 
    COMPONENT adder
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
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder PORT MAP (
          lhs => lhs,
          rhs => rhs,
          result => result
        );

   stim_proc: process
   begin		
        lhs <= x"0";
        rhs <= x"0";
        wait for 10 ns;
        assert result = x"0";

        lhs <= x"1";
        rhs <= x"0";
        wait for 10 ns;
        assert result = x"1";
        
        lhs <= x"0";
        rhs <= x"1";
        wait for 10 ns;
        assert result = x"1";
        
        lhs <= x"1";
        rhs <= x"1";
        wait for 10 ns;
        assert result = x"2";

        lhs <= x"2";
        rhs <= x"0";
        wait for 10 ns;
        assert result = x"2";
        
        wait for 10 ns;	
        lhs <= x"0";
        rhs <= x"2";
        wait for 10 ns;
        assert result = x"2";
        
        lhs <= x"2";
        rhs <= x"1";
        wait for 10 ns;
        assert result = x"3";
        
        lhs <= x"1";
        rhs <= x"2";
        wait for 10 ns;
        assert result = x"3";
        
        lhs <= x"2";
        rhs <= x"2";
        wait for 10 ns;
        assert result = x"4";
        
        lhs <= x"3";
        rhs <= x"0";
        wait for 10 ns;
        assert result = x"3";
        
        lhs <= x"3";
        rhs <= x"1";
        wait for 10 ns;
        assert result = x"4";
        
        lhs <= x"3";
        rhs <= x"2";
        wait for 10 ns;
        assert result = x"5";
        
        lhs <= x"3";
        rhs <= x"3";
        wait for 10 ns;
        assert result = x"6";

        wait;
   end process;

END;
