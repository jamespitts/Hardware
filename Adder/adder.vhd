
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity adder is
PORT(
        lhs: in std_logic_vector (1 downto 0) := "00";
        rhs: in std_logic_vector (1 downto 0) := "00";
        result: out std_logic_vector (2 downto 0)
);
end adder;

architecture Behavioral of adder is
    signal carry: std_logic;
    signal sum: std_logic_vector(2 downto 0) := "000";
begin
    half_adder: process (lhs, rhs)
    begin
        sum(0) <= lhs(0) xor rhs(0);
        carry <= lhs(0) and rhs(0);
     end process;
    
    
    full_adder: process (carry, lhs, rhs)
    begin
        sum(1) <= carry xor (lhs(1) xor rhs(1));
        sum(2) <= (carry and (lhs(1) xor rhs(1))) or (lhs(1) and rhs(1));
    end process;
    
    result <= sum;
    
end Behavioral;

