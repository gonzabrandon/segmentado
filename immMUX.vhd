library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity immMUX is
    Port ( cRs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           imm32 : in  STD_LOGIC_VECTOR (31 downto 0);
           selector_bit : in  STD_LOGIC;
           Operando_ALU : out  STD_LOGIC_VECTOR (31 downto 0));
end immMUX;

architecture Behavioral of immMUX is

begin

process(cRs2,imm32,selector_bit)
begin
	if(selector_bit='1') then
		Operando_ALU <= imm32;
	else
		Operando_ALU <= cRs2;
	end if;
end process;

end Behavioral;

