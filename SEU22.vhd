
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU22 is
    Port ( SEU22 : in  STD_LOGIC_VECTOR (21 downto 0);
           SEU32 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU22;

architecture Behavioral of SEU22 is

begin
process(SEU22)
	begin
		if(SEU22(21) = '1')then
			SEU32(21 downto 0) <= SEU22;
			SEU32(31 downto 22) <= (others=>'1');
		else
			SEU32(21 downto 0) <= SEU22;
			SEU32(31 downto 22) <= (others=>'0');
		end if;
	end process;

end Behavioral;

