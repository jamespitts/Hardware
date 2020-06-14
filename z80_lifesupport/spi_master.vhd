----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:38:25 05/07/2020 
-- Design Name: 
-- Module Name:    spi_master - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
  use ieee.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_master is 
    port (clk : in std_logic;
          reset : in std_logic;
          
          data_in : in std_logic_vector(7 downto 0);
          data_out : out std_logic_vector(7 downto 0);

          start : in std_logic;
          load: in std_logic;
          last: in std_logic;
          done: out std_logic;

          spi_cs: out std_logic;
          spi_mosi: out std_logic;
          spi_miso: in std_logic;
          spi_clk: out std_logic
    );
end spi_master;

architecture Behavioral of spi_master is
    type state_type is (ready_state, busy_state, done_state);
    signal state: state_type := ready_state;
    signal send_len : std_logic_vector(3 downto 0);
    signal data : std_logic_vector(7 downto 0);
begin
    process (clk, reset) is
    begin
        if reset='0'
        then
            data_out <= (others=>'0');
            spi_cs <='1';
            spi_mosi <= '0';
            data <= (others => '0');
            send_len <= x"0";
        elsif falling_edge(clk) then
            if (start='1' and state=ready_state) or state = busy_state
            then
                state <= busy_state;
                spi_cs <= '0';
                spi_mosi <= data(7);
                data <= data(6 downto 0) & spi_miso;
                send_len <= send_len - x"1";
                if send_len = x"0"
                then
                    state <= done_state;
                    spi_cs <= last;
                    data_out <= data;
                end if;
            elsif load = '1' and not (state = busy_state)
            then
                send_len <= x"8";
                data <= data_in;
                state <= ready_state;
            end if; 
        end if; 
    end process;
    
   
    done <= '1' when state=done_state else '0';
    
    process(clk, reset,state) is
    begin
        if reset='0'
        then
            spi_clk <='0';
        elsif state = busy_state
        then
            spi_clk <= clk;
        end if;
    end process;
    
end Behavioral;

