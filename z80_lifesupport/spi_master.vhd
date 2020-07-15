
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity spi_master is 
    port (clk : in std_logic;
          reset : in std_logic;
          
          data_in : in std_logic_vector(7 downto 0);
          data_out : out std_logic_vector(7 downto 0) := x"00";
          
          cmd: in std_logic_vector(1 downto 0);
          ready: out std_logic := '0';

          spi_cs: out std_logic := '0';
          spi_mosi: out std_logic := '0';
          spi_miso: in std_logic;
          spi_clk: out std_logic := '0'
    );
end spi_master;

architecture Behavioral of spi_master is
    type state_type is (reset_state, ready_state, running_state, busy_state, done_state);
    signal state: state_type := reset_state;
    signal send_len : std_logic_vector(3 downto 0);
    signal data : std_logic_vector(7 downto 0);
    signal last: std_logic;
begin

    process (clk, reset, cmd) is
    begin
        if reset='0'
        then
            spi_cs <='1';
            spi_mosi <= '0';
            data <= (others => '0');
            state <= ready_state;
            send_len <= x"0";
         elsif cmd(0) = '1' and state = ready_state 
         then
            state <= running_state;
            data <= data_in;
            spi_mosi <= data_in(7);
            send_len <= x"8";
            spi_cs <= '0';
            last <= cmd(1); -- last byte of sequence raise cs when done
        else
            if rising_edge(clk) or falling_edge(clk) 
            then
               if state = running_state and clk='1' -- on rising clock
               then
                   send_len <= send_len - 1;
                   data <= data(6 downto 0) & spi_miso;

               elsif state = running_state and clk='0' -- on falling clock
               then
                   spi_mosi <= data(7);                   
                   if send_len = x"0"
                   then
                       state <= done_state;
                       spi_cs <= last; 
                       data_out <= data;
                   end if;                   
               elsif state = done_state  and cmd /= "01"
               then
                   state <= ready_state;
               end if;
           end if;
        end if; 
    end process;
    
    process(clk, state)
    begin
      if state = running_state
      then
         if rising_edge(clk) or falling_edge(clk)
         then
            spi_clk <= clk;
         end if;
      end if;
    end process;
   
    ready <= '1' when state = ready_state else '0';
    
end Behavioral;

