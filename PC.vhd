
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    Port ( PC_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           PC_OUT : out  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0'));
end PC;

architecture Behavioral of PC is

begin

process(CLK,PC_IN,reset)
begin
	if(rising_edge(CLK)) then
		if(reset = '1') then
			PC_OUT <= (others=> '0');
		else
			PC_OUT <= PC_IN;
		end if;
	end if;
end process;	

end Behavioral;

