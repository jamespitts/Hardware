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
          done: out std_logic;

          spi_cs: out std_logic;
          spi_mosi: out std_logic;
          spi_miso: in std_logic;
          spi_clk: out std_logic
    );
end spi_master;

architecture Behavioral of spi_master is
    type state_type is (ready, busy);
    signal state: state_type := ready;
    signal send_len : std_logic_vector(2 downto 0);
    signal data : std_logic_vector(7 downto 0);
begin
    process (clk, reset) is
    begin
        if reset='0'
        then
            data_out <= (others=>'0');
            spi_cs <='1';
            spi_mosi <= '0';
            spi_clk <= '0';
            done <= '0';
            data <= (others => '0');
            send_len <= "000";
        elsif falling_edge(clk) then
            if (start='1' and state=ready) or state = busy
            then
                state <= busy;
                spi_cs <= '0';
                spi_mosi <= data(7);
                data <= data(6 downto 0) & spi_miso;
                send_len <= send_len - "001";
                if send_len = "000"
                then
                    state <= ready;
                    done <= '1';
                end if;
            elsif load = '1' and not (state = busy)
            then
                spi_cs <= '1';
                done <= '0';
                send_len <= "111";
                data <= data_in;
            end if; 
        end if; 
    end process;
    
    process(clk) is
    begin
        if rising_edge(clk) and state = ready
        then
      --   spi_clk <= not clk;
        end if;
    end process;
    
end Behavioral;

