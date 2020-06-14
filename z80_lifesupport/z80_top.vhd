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
          z80_data: inout std_logic_vector (7 downto 0);
          z80_m1: in std_logic;
          z80_mreq : in std_logic;
          z80_rd : in std_logic;
          z80_wait : out std_logic;
          
          w25_cs: out std_logic;
          w25_clk: out std_logic;
          w25_mosi: out std_logic;
          w25_miso: in std_logic;
          
          led_1: out std_logic := '0';
          led_2: out std_logic := '0'
    );    
end z80_top;

architecture Behavioral of z80_top is

--  COMPONENT MCU
--	PORT(
--        reset : IN std_logic;
--		clk : IN std_logic;
--        
--        -- from z80
--		rd : IN std_logic;
--		m1 : IN std_logic;
--		mreq : IN std_logic;
--        hold: out std_logic;
--		addr : IN std_logic_vector(15 downto 0);       
--		data : OUT std_logic_vector(7 downto 0);
--        
--        spi_addr: out std_logic_vector(1 downto 0);
--        spi_data: in std_logic_vector(7 downto 0)
--		);
--	END COMPONENT;
    
    COMPONENT spi_master
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;

		data_in : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0);
        
        start : in std_logic;
        load: in std_logic;
        done: out std_logic;
        
		spi_cs : OUT std_logic;
		spi_mosi : OUT std_logic;
        spi_miso : IN std_logic;          
		spi_clk : OUT std_logic
		);
	END COMPONENT;
    
    --signal spi_data: std_logic_vector(7 downto 0);
    --signal spi_addr: std_logic_vector(1 downto 0);
    signal dummy_addr: std_logic_vector (11 downto 0)  := (others => '0'); -- pad out the remaining address lines
    signal data_in: std_logic_vector(7 downto 0);
    signal data_out: std_logic_vector(7 downto 0) := (others => '0');
    signal done: std_logic;
    signal load: std_logic;
    signal start: std_logic;
begin

    led_1 <= '0';
    led_2 <= '0';
    
--    inst_mcu: MCU port map(
--        reset=>reset, 
--        clk=>clk,
--
--        rd => z80_rd,
--		m1 => z80_m1,
--		mreq => z80_mreq,
--        hold => z80_wait,
--        addr(3 downto 0) => z80_addr, 
--        addr(15 downto 4) => dummy_addr, 
--        data=>z80_data,
--        
--       -- spi_addr=>spi_addr,
--        spi_data=>data_out
--    );
    
    inst_spi_master: spi_master PORT MAP(
		clk => clk,
		reset => reset,
     
		data_in => data_in,
        data_out => data_out,
        
        start=>start,
        done=>done,
        load=>load,

        spi_cs => w25_cs,
        spi_miso => w25_miso,
		spi_mosi => w25_mosi,
		spi_clk => w25_clk
	);
    
end Behavioral;

