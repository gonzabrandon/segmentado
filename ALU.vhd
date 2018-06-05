
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( CRs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           CRs2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_OP : in STD_LOGIC_VECTOR (5 downto 0);
           ALU_Result : out  STD_LOGIC_VECTOR (31 downto 0);
			  Carry : in STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

begin
	process(CRs1,CRs2,ALU_OP,Carry)
	begin
	   case (ALU_OP) is 
			when "000000" => -- add,addcc
				ALU_Result <= CRs1 + CRs2;
			when "000001" => -- sub,subcc
				ALU_Result <= CRs1 - CRs2;
			when "000010" => --and
				ALU_Result <= CRs1 and CRs2;
			when "100010" => --andn
				ALU_Result <= CRs1 nand CRs2;
			when "000011" => -- or
				ALU_Result <= CRs1 or CRs2;
			when "100011" => -- nor
				ALU_Result <= CRs1 nor CRs2;
			when "000100" => -- xor
				ALU_Result <= CRs1 xor CRs2;
			when "100100" => -- xnor
				ALU_Result <= CRs1 xnor CRs2;
			when "000101" => -- addX,addXcc
				ALU_Result <= CRs1 + CRs2 + Carry;
			when "000110" => --subX,subXcc
				ALU_Result <= CRs1 - CRs2 - Carry;
			when others =>
				ALU_Result <= (others=>'0');
		end case;
	end process;

end Behavioral;

