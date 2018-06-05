
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SEU30 is
    Port ( SEU30 : in  STD_LOGIC_VECTOR (29 downto 0);
           SEU32 : out  STD_LOGIC_VECTOR (31 downto 0));
end SEU30;

architecture Behavioral of SEU30 is

begin
process(SEU30)
	begin
		if(SEU30(29) = '1')then
			SEU32(29 downto 0) <= SEU30;
			SEU32(31 downto 30) <= (others=>'1');
		else
			SEU32(29 downto 0) <= SEU30;
			SEU32(31 downto 30) <= (others=>'0');
		end if;
	end process;

end Behavioral;

