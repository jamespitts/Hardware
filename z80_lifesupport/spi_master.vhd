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
          
          addr: in std_logic_vector (1 downto 0);
          data : inout std_logic_vector(7 downto 0);

          spi_cs: out std_logic;
          spi_mosi: out std_logic;
          spi_miso: in std_logic;
          spi_clk: out std_logic
    );
end spi_master;

architecture Behavioral of spi_master is

begin
    spi_cs <='0';
    spi_mosi <= '0';
    spi_clk <= '0';
end Behavioral;

