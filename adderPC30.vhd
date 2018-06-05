
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity adderPC30 is
	Port ( disp30 : in  STD_LOGIC_VECTOR (31 downto 0);
          PC_actual : in  STD_LOGIC_VECTOR (31 downto 0);
          suma : out  STD_LOGIC_VECTOR (31 downto 0));
end adderPC30;

architecture Behavioral of adderPC30 is

begin
process(disp30,PC_actual) is
begin
	suma <= std_logic_vector(unsigned(disp30) + unsigned(PC_actual));
end process;
end Behavioral;

