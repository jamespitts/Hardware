----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:43:08 05/05/2020 
-- Design Name: 
-- Module Name:    z80_top - Behavioral 
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

entity z80_top is
    port (reset: in std_logic;
          clk: in std_logic;
          z80_addr: in std_logic_vector (3 downto 0);
          z80_m1: in std_logic;
          z80_mreq : in std_logic;
          z80_rd : in std_logic;
          z80_wait : out std_logic;
          
          w25q_cs: out std_logic;
          w25q_clk: out std_logic;
          w25q_di: out std_logic;
          w25q_do: out std_logic);    
end z80_top;

architecture Behavioral of z80_top is
    component w25q
    port (reset: in std_logic;
          clk: in std_logic;
          z80_addr: in std_logic_vector (3 downto 0);
          w25q_cs: out std_logic;
          w25q_clk: out std_logic;
          w25q_di: out std_logic;
          w25q_do: out std_logic
          ); 
    end component;
    
    component z80 
    port (clk: in std_logic;
          reset: in std_logic;
          z80_m1 : in std_logic;
          z80_mreq : in std_logic;
          z80_rd : in std_logic;
          z80_wait : out std_logic
          );
    end component;

begin

    w25: entity w25q port map(clk=>clk, reset=>reset, z80_addr=>z80_addr, w25q_cs=>w25q_cs,
    w25q_clk=>w25q_clk, w25q_di=> w25q_di, w25q_do=>w25q_do);
    z80_entity: entity z80 port map(clk=>clk, reset=>reset, z80_m1=>z80_m1, z80_mreq=>z80_mreq, z80_rd=>z80_rd, z80_wait=>z80_wait);
  


end Behavioral;

