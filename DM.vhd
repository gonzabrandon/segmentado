
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DM is
    Port ( --clk : in  STD_LOGIC;
           --reset : in  STD_LOGIC;
			  --enableMem: in STD_LOGIC;
           wrenmem : in  STD_LOGIC;
           addressDM : in  STD_LOGIC_VECTOR (31 downto 0);--Direccion es lo mismo que ALU_RESULT?
           CRd : in  STD_LOGIC_VECTOR (31 downto 0);
           data : out  STD_LOGIC_VECTOR (31 downto 0):=(others=>'0'));
end DM;

architecture Behavioral of DM is

type ram_type is array (0 to 63) of std_logic_vector (31 downto 0);
signal ramMemory : ram_type:=(others => x"00000000");

begin
--process(clk)
process (cRD,wrenmem,addressDM,ramMemory)
begin
	--if(falling_edge(clk))then
		--if(enableMem = '1') then
--			if(reset = '1')then
--				data <= (others => '0');
--				ramMemory <= (others => x"00000000");
			--else
				if wrenmem = '0' then
					data <= ramMemory(conv_integer(addressDM(5 downto 0)));
				else
					ramMemory(conv_integer(addressDM(5 downto 0))) <= CRd;
				end if;
			--end if;
		--end if;
	--end if;
--end process;
end process;

end Behavioral;

