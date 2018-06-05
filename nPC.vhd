
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nPC is
    Port ( PC_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           nPC_OUT : out  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0'));
end nPC;

architecture Behavioral of nPC is

begin
process(clk,PC_IN,reset)
begin
	if(rising_edge(CLK)) then
		if(reset = '1') then
			nPC_OUT <= (others=> '0');
		else
			nPC_OUT <= PC_IN;
		end if;
	end if;
end process;	

end Behavioral;

