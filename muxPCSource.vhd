
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity muxPCSource is
	Port (  PCDisp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           PCDisp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC1 : in  STD_LOGIC_VECTOR (31 downto 0);
           PCAddress : in  STD_LOGIC_VECTOR (31 downto 0);
           PCSource : in  STD_LOGIC_VECTOR (1 downto 0);
           PCAddressOut : out  STD_LOGIC_VECTOR (31 downto 0));
end muxPCSource;

architecture Behavioral of muxPCSource is

begin
	process(PCDisp30,PCDisp22,PC1,PCAddress,PCSource)
	begin
			case PCSource is
				when "00" =>
					PCAddressOut <= PCAddress;
				when "01" =>
					PCAddressOut <= PCDisp30;
				when "10" =>
					PCAddressOut <= PCDisp22;
				when "11" =>
					PCAddressOut <= PC1;
				when others =>
					PCAddressOut <= PC1;
			end case;
	end process;

end Behavioral;

