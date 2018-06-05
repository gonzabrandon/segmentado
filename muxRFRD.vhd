
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity muxRFRD is
    Port ( wmnRD : in  STD_LOGIC_VECTOR (5 downto 0);--Windows Manager new RD
           rO7 : in  STD_LOGIC_VECTOR (5 downto 0);--O7 register
           RFdest_sel : in  STD_LOGIC;--Selector rf destination
           nRd : out  STD_LOGIC_VECTOR (5 downto 0));-- new RD
end muxRFRD;

architecture Behavioral of muxRFRD is

begin
	process(wmnRd,rO7,RFdest_sel)
	begin
		if(RFdest_sel = '0')then
			nRd <= wmnRd;
		else
			if(RFdest_sel = '1')then
				nRd <= rO7;
			end if;
		end if;
	end process;

end Behavioral;

