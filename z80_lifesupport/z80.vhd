----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:28:04 05/02/2020 
-- Design Name: 
-- Module Name:    z80 - Behavioral 
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

entity z80 is 
    port (clk: in std_logic;
          z80_m1 : in std_logic;
          z80_mreq : in std_logic;
          z80_rd : in std_logic;
          reset: in std_logic;
          z80_wait : out std_logic := 'Z'
          );
end z80;

architecture Behavioral of z80 is
    type state_type is (state_idle, state_ins_read, state_wait_1);
    signal state: state_type := state_idle;
begin
    --z80_WAIT <= 'Z' when(z80_MREQ='1') else '0';

--z80_wait <= 'Z' when (reset='1') else '0';
    
    process(clk, reset) is
    begin
    if rising_edge(clk)
    then
        case state is

            when state_idle => 
                
                if Z80_mreq = '0' and z80_m1='0' and z80_rd='0'
                then
                   state <= state_ins_read;
                end if;
            when state_ins_read =>
                state <= state_wait_1;                
            when state_wait_1 =>
                state <= state_idle;                
        end case;
    end if;  
    end process;  

    -- z80_wait == 0 - block
    -- z80_wait == Z - freewheel
    
    --z80_wait <= 'Z';
    --z80_wait <= '0' when (state=state_reset or state=state_ins_read) else 'Z'; -- lets z80 freewheel with wait during reset cycle
    z80_wait <= '0' when (state=state_ins_read) else 'Z'; 

end Behavioral;

