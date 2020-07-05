
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    port(
        lhs_led: out std_logic_vector(3 downto 0);
        rhs_led: out std_logic_vector(3 downto 0);
        result_led: out std_logic_vector(4 downto 0);
        button_1_hi: in std_logic;
        button_1_lo: in std_logic;
        button_2_hi: in std_logic;
        button_2_lo: in std_logic;
        led_1: out std_logic;
        clk: in std_logic
    );
end top;

architecture Behavioral of top is
    COMPONENT adder
    PORT(
		lhs : IN std_logic_vector(3 downto 0);
		rhs : IN std_logic_vector(3 downto 0);          
		result : OUT std_logic_vector(4 downto 0)
		);
	 END COMPONENT;
    
    COMPONENT input
	 PORT(
      clk: in std_logic;
		button_hi : IN std_logic;          
      button_lo : IN std_logic;          
		value: OUT std_logic_vector(3 downto 0)
		);
	 END COMPONENT;
    
    COMPONENT clockdivider
    PORT(
         clk : IN  std_logic;
         clk_out : OUT  std_logic
        );
    END COMPONENT;

    
    COMPONENT debounce
	 PORT(
		clk : IN std_logic;
		signal_in : IN std_logic;          
		signal_out : OUT std_logic
		);
	 END COMPONENT;
    
    signal lhs: std_logic_vector(3 downto 0);
    signal rhs: std_logic_vector(3 downto 0);
    signal result: std_logic_vector(4 downto 0);
    
    signal button_1_hi_debounced: std_logic;
    signal button_1_lo_debounced: std_logic;
    
    signal button_2_hi_debounced: std_logic;
    signal button_2_lo_debounced: std_logic;
    
    signal clk_out: std_logic;
begin

	Inst_adder: adder PORT MAP(
		lhs => lhs,
		rhs => rhs,
		result => result
	);
    
    Inst_input_lhs: input PORT MAP(
      clk => clk,
		button_hi => button_1_hi_debounced,
      button_lo => button_1_lo_debounced,
		value => lhs
	);
    
    Inst_input_rhs: input PORT MAP(
      clk => clk,
		button_hi => button_2_hi_debounced,
      button_lo => button_2_lo_debounced,
		value => rhs
	);
   
   Inst_clockdivider_1: clockdivider PORT MAP (
          clk => clk,
          clk_out => clk_out
        );

	Inst_debounce_hi_1: debounce PORT MAP(
		clk => clk_out,
		signal_in => button_1_hi,
		signal_out => button_1_hi_debounced
	);
    
    Inst_debounce_lo_1: debounce PORT MAP(
		clk => clk_out,
		signal_in => button_1_lo,
		signal_out => button_1_lo_debounced
	);
    
    Inst_debounce_hi_2: debounce PORT MAP(
		clk => clk_out,
		signal_in => button_2_hi,
		signal_out => button_2_hi_debounced
	);
    
    Inst_debounce_lo_2: debounce PORT MAP(
		clk => clk_out,
		signal_in => button_2_lo,
		signal_out => button_2_lo_debounced
	);

    result_led <= result;
    lhs_led <= lhs;
    rhs_led <= rhs;
    led_1 <= button_1_hi_debounced or button_1_lo_debounced or button_2_hi_debounced or button_2_lo_debounced;
    
end Behavioral;

