
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity debounce is
    port(clk: in std_logic;
         signal_in: in std_logic;
         signal_out: out std_logic := '1');
end debounce;

architecture Behavioral of debounce is
    signal debouncer: std_logic_vector(3 downto 0) := x"0";
begin

    process(clk, debouncer, signal_in)
    begin
        if rising_edge(clk)
        then
            debouncer <= debouncer(2 downto 0) & signal_in;
        end if;
    end process;
    signal_out <= '1' when debouncer=x"f" else '0';

end Behavioral;

