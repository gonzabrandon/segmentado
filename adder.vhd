
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;


entity adder1 is
    Port ( a : in  STD_LOGIC_VECTOR (31 downto 0);
           b : in  STD_LOGIC_VECTOR (31 downto 0);
           suma : out  STD_LOGIC_VECTOR (31 downto 0));
end adder1;

architecture Behavioral of adder1 is

begin
process(a,b) is
begin
	suma <= std_logic_vector(unsigned(a) + unsigned(b));
end process;
end Behavioral;

