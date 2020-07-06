library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity input is
    port(clk: in std_logic; 
         reset: in std_logic;
         button_lo: in std_logic;
         button_hi: in std_logic;
         value: out std_logic_vector(3 downto 0)
    );
end input;

architecture Behavioral of input is
    signal working_value: std_logic_vector(3 downto 0) := x"0";
    signal button_1: std_logic := '0';
    signal button_2: std_logic := '0';
begin
    process(clk, reset, button_lo, button_hi, button_1, button_2)
    begin
      if rising_edge(clk)
      then
         if reset = '0'
         then
            working_value <= x"0";
         elsif (button_lo xor button_1) = '1'
            then
               if button_lo = '1'
               then
                  working_value <= working_value(2 downto 0) & '0';  
               end if;
               button_1 <= button_lo;
            elsif (button_hi xor button_2) = '1'
            then 
               if button_hi = '1'
               then
                  working_value <= working_value(2 downto 0) & '1';    
               end if;
               button_2 <= button_hi;
            end if;
       end if;
    end process;
    
    value <= working_value;
    
end Behavioral;

