
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY PC_tb IS
END PC_tb;
 
ARCHITECTURE behavior OF PC_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PC
    PORT(
         PC_IN : IN  std_logic_vector(31 downto 0);
         reset : IN  std_logic;
         CLK : IN  std_logic;
         PC_OUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal reset : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal PC_OUT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PC PORT MAP (
          PC_IN => PC_IN,
          reset => reset,
          CLK => CLK,
          PC_OUT => PC_OUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset<= '1';
		PC_IN<= "00000000100000001001000000000000";
      wait for 10 ms;	
		reset<= '0';
		PC_IN<= "00000000100000001001000000000000";
      wait;
   end process;

END;
