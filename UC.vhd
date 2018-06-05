
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UC is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  op2 : in STD_LOGIC_VECTOR (2 downto 0);
			  icc : in STD_LOGIC_VECTOR (3 downto 0);
			  cond: in STD_LOGIC_VECTOR (3 downto 0);
           aluOP : out  STD_LOGIC_VECTOR (5 downto 0);
			  enableDM: out STD_LOGIC;
			  wrenDM: out STD_LOGIC;
			  selectorDM: out STD_LOGIC_VECTOR(1 downto 0);
			  PCSource: out STD_LOGIC_VECTOR(1 downto 0);
			  RFdest: out STD_LOGIC;
			  write_enable : out STD_LOGIC);
end UC;

architecture Behavioral of UC is

begin
	process(op, op2, op3, icc, cond)
	begin
	if(op = "01") then --CALL
		PCSource<= "01";--PC + disp30
		write_enable <= '1';--Permitimos guardar datos en RF (Valor actual de PC)
		enableDM <= '1';--Habilitamos DM
		selectorDM<= "10";--Elegimos PC
		RFdest<='1';--Se debe elegir el O7 en el RF
		wrenDM <= '0';--No escribimos en DM
		aluOP <= "111111";--No hacemos operaciones aritmetico logicas
	else
		if(op= "00") then
			if(op2= "010") then
				case cond is
					when "1000" => --Branch Always
						PCSource<= "10";--PC + seu(disp22)
						write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
						enableDM <= '1';--Habilitamos DM
						selectorDM<= "00";--Elegimos aluresult
						RFdest<='0';--Se debe elegir nRd
						wrenDM <= '0';--No escribimos en DM
						aluOP <= "111111";--No hacemos operaciones aritmetico logicas
					when "1001" => --Branch on Not Equal
						if(not(icc(2)) = '1') then --not z
							PCSource<= "10";--PC + seu(disp22)
							write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
							enableDM <= '1';--Habilitamos DM
							selectorDM<= "00";--Elegimos aluresult
							RFdest<='0';--Se debe elegir nRd
							wrenDM <= '0';--No escribimos en DM
							aluOP <= "111111";--No hacemos operaciones aritmetico logicas
						else
							PCSource<= "11";--PC + 1
							write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
							enableDM <= '1';--Habilitamos DM
							selectorDM<= "00";--Elegimos aluresult
							RFdest<='0';--Se debe elegir nRd
							wrenDM <= '0';--No escribimos en DM
							aluOP <= "111111";--No hacemos operaciones aritmetico logicas
						end if;
					when "0001" => --Branch on Equal
						if(icc(2) = '1') then
							PCSource<= "10";--PC + seu(disp22)
							write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
							enableDM <= '1';--Habilitamos DM
							selectorDM<= "00";--Elegimos aluresult
							RFdest<='0';--Se debe elegir nRd
							wrenDM <= '0';--No escribimos en DM
							aluOP <= "111111";--No hacemos operaciones aritmetico logicas
						else
							PCSource<= "11";--PC + 1
							write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
							enableDM <= '1';--Habilitamos DM
							selectorDM<= "00";--Elegimos aluresult
							RFdest<='0';--Se debe elegir nRd
							wrenDM <= '0';--No escribimos en DM
							aluOP <= "111111";--No hacemos operaciones aritmetico logicas
						end if;
					when "1010" => --Branch on Greater
						if((not(icc(2) or (icc(3) xor icc(1)))) = '1') then --not(Z or (N xor V))
							PCSource<= "10";--PC + seu(disp22)
							write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
							enableDM <= '1';--Habilitamos DM
							selectorDM<= "00";--Elegimos aluresult
							RFdest<='0';--Se debe elegir nRd
							wrenDM <= '0';--No escribimos en DM
							aluOP <= "111111";--No hacemos operaciones aritmetico logicas
						else
							PCSource<= "11";--PC + 1
							write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
							enableDM <= '1';--Habilitamos DM
							selectorDM<= "00";--Elegimos aluresult
							RFdest<='0';--Se debe elegir nRd
							wrenDM <= '0';--No escribimos en DM
							aluOP <= "111111";--No hacemos operaciones aritmetico logicas
						end if;
					when "0010" => --Branch on Less or Equal
						if((icc(2) or (icc(3) xor icc(1))) = '1') then --Z or (N xor V)
							PCSource<= "10";--PC + seu(disp22)
							write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
							enableDM <= '1';--Habilitamos DM
							selectorDM<= "00";--Elegimos aluresult
							RFdest<='0';--Se debe elegir nRd
							wrenDM <= '0';--No escribimos en DM
							aluOP <= "111111";--No hacemos operaciones aritmetico logicas
						else
							PCSource<= "11";--PC + 1
							write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
							enableDM <= '1';--Habilitamos DM
							selectorDM<= "00";--Elegimos aluresult
							RFdest<='0';--Se debe elegir nRd
							wrenDM <= '0';--No escribimos en DM
							aluOP <= "111111";--No hacemos operaciones aritmetico logicas
						end if;
					when "1011" => -- Branch on Greater or Equal
						if((not(icc(3) xor icc(1))) = '1') then --not (N xor V)
							PCSource<= "10";--PC + seu(disp22)
							write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
							enableDM <= '1';--Habilitamos DM
							selectorDM<= "00";--Elegimos aluresult
							RFdest<='0';--Se debe elegir nRd
							wrenDM <= '0';--No escribimos en DM
							aluOP <= "111111";--No hacemos operaciones aritmetico logicas
						else
							PCSource<= "11";--PC + 1
							write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
							enableDM <= '1';--Habilitamos DM
							selectorDM<= "00";--Elegimos aluresult
							RFdest<='0';--Se debe elegir nRd
							wrenDM <= '0';--No escribimos en DM
							aluOP <= "111111";--No hacemos operaciones aritmetico logicas
						end if;
					when "0011" => --Branch on Less
						if((icc(3) xor icc(1)) = '1') then -- (N xor V)
							PCSource<= "10";--PC + seu(disp22)
							write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
							enableDM <= '1';--Habilitamos DM
							selectorDM<= "00";--Elegimos aluresult
							RFdest<='0';--Se debe elegir nRd
							wrenDM <= '0';--No escribimos en DM
							aluOP <= "111111";--No hacemos operaciones aritmetico logicas
						else
							PCSource<= "11";--PC + 1
							write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
							enableDM <= '1';--Habilitamos DM
							selectorDM<= "00";--Elegimos aluresult
							RFdest<='0';--Se debe elegir nRd
							wrenDM <= '0';--No escribimos en DM
							aluOP <= "111111";--No hacemos operaciones aritmetico logicas
						end if;
					when others =>
						PCSource<= "11";--PC + PCaddress
						write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
						enableDM <= '1';--Habilitamos DM
						selectorDM<= "00";--Elegimos aluresult
						RFdest<='0';--Se debe elegir nRd
						wrenDM <= '0';--No escribimos en DM
						aluOP <= "111111";--No hacemos operaciones aritmetico logicas
				end case;
			elsif(op2 = "100") then --NOP
				PCSource<= "11";--PC + 1
				write_enable <= '0';--Permitimos guardar datos en RF (Valor actual de PC)
				enableDM <= '1';--Habilitamos DM
				selectorDM<= "01";--Elegimos aluresult
				RFdest<='0';--Se debe elegir nRd
				wrenDM <= '0';--No escribimos en DM
				aluOP <= "111111";--No hacemos operaciones aritmetico logicas
			end if;
		elsif(op = "10")then				
			case op3 is
				when "000000" => -- ADD
					aluOP <= "000000";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "010000" => --ADDcc
					aluOP <= "000000";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "001000" => --ADDX
					aluOP <= "000101";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "011000" => --ADDXcc
					aluOP <= "000101";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "000100" => -- SUB
					aluOP <= "000001";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "010100" => -- SUBcc
					aluOP <= "000001";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "001100" => -- SUBX
					aluOP <= "000110";
					write_enable <= '1';
					selectorDM<= "00";
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
					
				when "011100" => -- SUBXcc
					aluOP <= "000110";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "000001" => -- AND
					aluOP <= "000010";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "010001" => -- ANDcc
					aluOP <= "000010";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "000101" => --ANDN
					aluOP <= "100010";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
				when "010101" => --ANDNcc
					aluOP <= "100010";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "000010" => -- OR
					aluOP <= "000011";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "010010" => -- ORcc
					aluOP <= "000011";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "000110" => --NOR
					aluOP <= "100011";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "010110" => --NORcc
					aluOP <= "100011";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "000011" => -- XOR
					aluOP <= "000100";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "010011" => -- XORcc
					aluOP <= "000100";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "000111" => -- XNOR
					aluOP <= "100100";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "010111" => -- XNORcc
					aluOP <= "100100";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "111100" => -- SAVE
					aluOP <= "000000";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "111101" => -- RESTORE
					aluOP <= "000000";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "111000" => --JMPL
					aluOP <= "000000";
					write_enable <= '1';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "10";
					PCSource<= "00";--PC calculada
					RFdest<='0';--Se debe elegir el nrd en el RF
				when others => --En otros casos desconocidos
					aluOP <= "111111";
					write_enable <= '0';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
			end case;
		elsif(OP = "11") then
			case op3 is
				when "000100" => --SW
					aluOP <= "000000";
					write_enable <= '0';
					enableDM <= '1';--Habilitamos el DataMemory
					wrenDM <= '1';--Habilitamos la escritura en el DM
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when "000000" => --LW
					aluOP <= "000000";
					write_enable <= '1';--Habilitamos la escritura en el RF
					enableDM <= '1';
					wrenDM <= '0';--Si no habilitamos la escritura, es porque vamos a leer
					selectorDM<= "01";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				when others =>
					aluOP <= "000000";
					write_enable <= '0';
					enableDM <= '1';
					wrenDM <= '0';
					selectorDM<= "00";
					PCSource<= "11";--Se salta a PC + 1
					RFdest<='0';--Se debe elegir el nrd en el RF
				end case;
		end if;
	end if;
end process;

end Behavioral;

