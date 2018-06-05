
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dwrMUX is
    Port ( selector: in STD_LOGIC_VECTOR(1 downto 0);
			  data : in  STD_LOGIC_VECTOR (31 downto 0);
           alu_result : in  STD_LOGIC_VECTOR (31 downto 0);
			  PC: in STD_LOGIC_VECTOR(31 downto 0);
           data_to_write : out  STD_LOGIC_VECTOR (31 downto 0));
end dwrMUX;

architecture Behavioral of dwrMUX is

begin
process(data,alu_result,selector)
begin
	if(selector = "00")then
		data_to_write <= alu_result;
	elsif(selector="01")then
		data_to_write <= data;
	elsif(selector= "10")then
		data_to_write <= PC;
	else
		data_to_write<=alu_result;
	end if;
end process;
end Behavioral;

