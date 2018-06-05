
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PSR_modifier is
    Port ( bRs1 : in  STD_LOGIC;--Bit mas significativo del registro 1
           bRs2 : in  STD_LOGIC;--Bit menos significativo del registro 2
           OP3: in  STD_LOGIC_VECTOR (5 downto 0);
			  --OP: in STD_LOGIC_VECTOR(1 downto 0);
           ALU_result : in  STD_LOGIC_VECTOR (31 downto 0);
           NZVC : out  STD_LOGIC_VECTOR (3 downto 0):="0000");
end PSR_modifier;

architecture Behavioral of PSR_modifier is

begin
process(ALU_result,bRs1,bRs2,OP3)
begin
	--if(OP= "10") then
		if(OP3 = "010000" or OP3 = "011000")then--ADDCC ADDXCC
			NZVC(3) <= ALU_result(31);	
			if(ALU_result = X"00000000")then
				NZVC(2) <= '1';
			else
				NZVC(2) <= '0';
			end if;
			NZVC(1) <= (bRs1 and bRs2 and (not ALU_result(31))) or ((bRs1) and (not bRs2) and ALU_result(31));
			NZVC(0) <= (bRs1 and bRs2) or ((not ALU_result(31)) and (bRs1 or bRs2));
			
		elsif(OP3 = "010100" or OP3="011100")then--SUBCC SUBXCC
				NZVC(3) <= ALU_result(31);
				if(ALU_result = X"00000000")then
					NZVC(2) <= '1';
				else
					NZVC(2) <= '0';
				end if;
				NZVC(1) <= ((bRs1 and (not bRs2) and (not ALU_result(31))) or ((not bRs1) and bRs2 and ALU_result(31)));
				NZVC(0) <= ((not bRs1) and bRs2) or (ALU_result(31) and ((not bRs1) or bRs2));
		
		elsif(OP3 = "010001" or OP3 = "010101" or OP3 = "010010" or OP3 = "010110" or OP3 = "010011" or OP3 = "010111")then --ANDcc,ANDNcc,ORcc,NORcc,XORcc,XNORcc
					NZVC(3) <= ALU_result(31);
					if(ALU_result = X"00000000")then
						NZVC(2) <= '1';
					else
						NZVC(2) <= '0';
					end if;
					NZVC(1) <= '0';
					NZVC(0) <= '0';
		end if;
	--end if;
end process;

end Behavioral;

