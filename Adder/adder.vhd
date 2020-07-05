
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity adder is
PORT(
        lhs: in std_logic_vector (3 downto 0) := x"0";
        rhs: in std_logic_vector (3 downto 0) := x"0";
        result: out std_logic_vector (4 downto 0)
);
end adder;

architecture Behavioral of adder is
    signal carry: std_logic_vector(3 downto 0) := x"0";
    signal sum: std_logic_vector(4 downto 0) := "00000";
begin
    half_adder: process (lhs, rhs)
    begin
        sum(0) <= lhs(0) xor rhs(0);
        carry(0) <= lhs(0) and rhs(0);
     end process;
    
    
    full_adder: process (carry, lhs, rhs)
    begin
        sum(1) <= carry(0) xor (lhs(1) xor rhs(1));
        carry(1) <= (carry(0) and (lhs(1) xor rhs(1))) or (lhs(1) and rhs(1));
        
        sum(2) <= carry(1) xor (lhs(2) xor rhs(2));
        carry(2) <= (carry(1) and (lhs(2) xor rhs(2))) or (lhs(2) and rhs(2));
        
        sum(3) <= carry(2) xor (lhs(3) xor rhs(3));
        sum(4) <= (carry(2) and (lhs(3) xor rhs(3))) or (lhs(3) and rhs(3));        
    end process;
    
    result <= sum;
    
end Behavioral;

