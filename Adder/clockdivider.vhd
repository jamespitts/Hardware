
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity clockdivider is
   port(clk: in std_logic;
        clk_out: out std_logic
   );
end clockdivider;

architecture Behavioral of clockdivider is
signal counter: unsigned(15 downto 0) := x"0000";
begin
process(clk, counter)
begin
   if rising_edge(clk)
   then
      counter <= counter + 1;
   end if;
end process;

clk_out <= '1' when counter(14) = '1' else '0';

end Behavioral;

