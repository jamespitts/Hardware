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

entity W25Q is
    port (reset: in std_logic;
          clk: in std_logic;
          z80_addr: in std_logic_vector (3 downto 0);
          w25q_cs: out std_logic;
          w25q_clk: out std_logic;
          w25q_di: out std_logic;
          w25q_do: out std_logic);
end W25Q;

architecture Behavioral of W25Q is

begin
w25q_cs <=reset;
process(clk, reset) is
begin
    if reset='1'
    then
    end if;
end process;

end Behavioral;

