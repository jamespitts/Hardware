
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity debounce is
    port(clk: in std_logic;
         signal_in: in std_logic;
         signal_out: out std_logic := '1');
end debounce;

architecture Behavioral of debounce is
    signal debouncer: std_logic_vector(7 downto 0) := x"00";
begin

    process(clk, debouncer, signal_in)
    begin
        if rising_edge(clk)
        then
            debouncer <= debouncer(6 downto 0) & signal_in;
        end if;
    end process;
    signal_out <= '1' when debouncer=x"ff" else '0';

end Behavioral;

