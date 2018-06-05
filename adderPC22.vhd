
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity adderPC22 is
	Port ( PC_actual : in  STD_LOGIC_VECTOR (31 downto 0);
          disp22 : in  STD_LOGIC_VECTOR (31 downto 0);
          suma : out  STD_LOGIC_VECTOR (31 downto 0));
end adderPC22;

architecture Behavioral of adderPC22 is

begin
process(PC_actual,disp22) is
begin
	suma <= std_logic_vector(unsigned(PC_actual) + unsigned(disp22));
end process;
end Behavioral;

