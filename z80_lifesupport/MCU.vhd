----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:21:25 05/05/2020 
-- Design Name: 
-- Module Name:    W25Q - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MCU is
    port (reset: in std_logic;
          clk: in std_logic;

          -- z80
          rd: in std_logic;
          m1: in std_logic;
          mreq: in std_logic;
          hold: out std_logic;
          addr: in std_logic_vector (15 downto 0);
          data: inout std_logic_vector(7 downto 0);
          
          spi_addr: out std_logic_vector(1 downto 0);
          spi_data: inout std_logic_vector(7 downto 0);
          spi_busy: in std_logic
          );
end MCU;


architecture Behavioral of MCU is
    type state_type is (ready, addr_0, addr_1, addr_2, done);
    signal state: state_type := ready;
    --signal read_addr: std_logic_vector(15 downto 0);
    signal spi_done: std_logic;
begin

    process(clk, reset) is
    begin
        if reset='0'
        then
        hold <= 'Z';
        elsif rising_edge(clk)
        then 
            if state = ready and rd = '0' and mreq = '0' and spi_busy='0'  -- read operation
            then
                hold <= '0'; -- halt the z80
                
                spi_addr <= "00"; -- write operation
                spi_data <= x"03"; -- prom read operation
                state <= addr_0;
                
            elsif state = addr_0
            then
                spi_addr <= "00"; 
                spi_data <= addr(7 downto 0);
                state <= addr_1;
            elsif state = addr_1
            then
                spi_addr <= "00"; 
                spi_data <= addr(15 downto 8);
                state <= addr_2;    
            elsif state = addr_2
            then
                spi_addr <= "00"; 
                spi_data <= (others => '0');
                state <= done;
            elsif state = done
            then
                hold <='Z';
            end if;
        
        end if;
    end process;

end Behavioral;

