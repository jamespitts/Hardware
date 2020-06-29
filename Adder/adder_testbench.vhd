
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY adder_testbench IS
END adder_testbench;
 
ARCHITECTURE behavior OF adder_testbench IS 
 
 
    COMPONENT adder
    PORT(
         lhs : IN  std_logic_vector(1 downto 0);
         rhs : IN  std_logic_vector(1 downto 0);
         result : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal lhs : std_logic_vector(1 downto 0) := (others => '0');
   signal rhs : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(2 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder PORT MAP (
          lhs => lhs,
          rhs => rhs,
          result => result
        );

   stim_proc: process
   begin		
        lhs <= "00";
        rhs <= "00";
        wait for 10 ns;
        assert result = "000";

        lhs <= "01";
        rhs <= "00";
        wait for 10 ns;
        assert result = "001";
        
        lhs <= "00";
        rhs <= "01";
        wait for 10 ns;
        assert result = "001";
        
        lhs <= "01";
        rhs <= "01";
        wait for 10 ns;
        assert result = "010";

        lhs <= x"2";
        rhs <= x"0";
        wait for 10 ns;
        assert result = "10";
        
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
