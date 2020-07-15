
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY test_spi_master IS
END test_spi_master;
 
ARCHITECTURE behavior OF test_spi_master IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT spi_master
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         
         data_in : IN  std_logic_vector(7 downto 0);
         data_out : OUT  std_logic_vector(7 downto 0);
         
         cmd: in std_logic_vector(1 downto 0);
         ready: out std_logic;
         
         spi_cs : OUT  std_logic;
         spi_mosi : OUT  std_logic;
         spi_miso : IN  std_logic;
         spi_clk : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '1';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal spi_miso : std_logic := '0';


 	--Outputs
   signal spi_cs : std_logic;
   signal spi_mosi : std_logic;
   signal spi_clk : std_logic;
   
   signal data_out : std_logic_vector(7 downto 0);
  -- signal done : std_logic;
   
   signal ready: std_logic;
   signal cmd: std_logic_vector(1 downto 0) := "00";
   
   signal test_miso: std_logic_vector (7 downto 0) := x"AB";

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: spi_master PORT MAP (
          clk => clk,
          reset => reset,
          
          data_in => data_in,
          data_out => data_out,

          cmd => cmd,
          ready => ready,
          
          spi_cs => spi_cs,
          spi_mosi => spi_mosi,
          spi_miso => spi_miso,
          spi_clk => spi_clk
        );

   -- Clock process definitions
   clk_process :process(clk)
   begin
        clk <= (not clk) after clk_period/2;
   end process;
  
   -- Stimulus process
   stim_proc: process
   begin		
      reset <='1';
      wait for clk_period;
      reset <= '0';     
      wait for clk_period;
      reset <= '1';     

      wait for clk_period/4;
      
      assert ready = '1';

      data_in <= x"9F";
      
      wait until rising_edge(clk);
      wait for clk_period/8;
      cmd <= "01";
      
      wait until rising_edge(clk);
      cmd <= "00";
      
      wait until rising_edge(ready);
      
      data_in <= x"00";
      wait until rising_edge(clk);
      cmd <= "11";
      wait until rising_edge(clk);
      cmd <= "00";
      wait until rising_edge(ready);

      report "All done.";

      wait;
   end process;
   
   process (spi_clk, test_miso)
   begin
      if rising_edge(spi_clk)
      then
         test_miso <= test_miso(6 downto 0) & test_miso(7);
      end if;
   end process;
   
   spi_miso <= test_miso(7);

END;
