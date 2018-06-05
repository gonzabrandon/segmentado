
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PSR is
    Port ( clk : in  STD_LOGIC;
			  reset: in STD_LOGIC;
			  nCWP : in  STD_LOGIC;
           NZVC : in  STD_LOGIC_VECTOR (3 downto 0);
           CWP : out  STD_LOGIC:='0';
			  icc: out STD_LOGIC_VECTOR (3 downto 0);
           carry : out  STD_LOGIC);
end PSR;

architecture Behavioral of PSR is

signal PSRegister: STD_LOGIC_VECTOR (31 DOWNTO 0):= (others=>'0');

begin
	process(clk,reset,NZVC,nCWP)
	begin
		if(reset = '1') then
				CWP <= '0';
				carry <= '0';
				icc <= "0000";
		else
			if(rising_edge(clk))then
				PSRegister(0) <= nCWP;
				carry <= PSRegister(20);
				CWP <= nCWP;
			end if;
			PSRegister(23 downto 20) <= NZVC;
			icc <= PSRegister(23 downto 20);
		end if;
	end process;

end Behavioral;

