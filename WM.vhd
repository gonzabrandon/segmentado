
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity WM is
    Port ( Rs1 : in  STD_LOGIC_VECTOR (4 downto 0);--Register Source 1
           Rs2 : in  STD_LOGIC_VECTOR (4 downto 0);--Register Source 2
           Rd : in  STD_LOGIC_VECTOR (4 downto 0);--Register Destination
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           CWP : in  STD_LOGIC;--Current Window Pointer
			  RO7 : out STD_LOGIC_VECTOR (5 downto 0);
           nCWP : out  STD_LOGIC;--New Current Windows Pointer
           nRs1 : out  STD_LOGIC_VECTOR (5 downto 0);--New Register Source 1
           nRs2 : out  STD_LOGIC_VECTOR (5 downto 0);--New Register Source 2
           nRd : out  STD_LOGIC_VECTOR (5 downto 0));--New Register Destination
end WM;

architecture Behavioral of WM is

signal Rs1Integer,Rs2Integer,RdInteger: integer range 0 to 39:=0;
signal ncwp_signal: STD_LOGIC;
signal auxRO7: STD_LOGIC_VECTOR(5 downto 0):= "001111";

begin
	auxRO7 <= conv_std_logic_vector(conv_integer(cwp) * 16,6);
	RO7 <= auxRO7 + "001111";
	process(CWP,OP,OP3,Rs1,Rs2,Rd,ncwp_signal)
	begin
		if(OP = "10") then
			if(OP3 = "111100")then--SAVE
				if(CWP = '1')then
					ncwp_signal <= '0';--Aumentamos el cwp
				end if;
			elsif(OP3 = "111101")then--RESTORE
				if(CWP = '0')then
					ncwp_signal <= '1';--Disminuimos el cwp
				end if;
			end if;
		else
				ncwp_signal <= CWP;
		end if;
		
		if(Rs1>="11000" and Rs1<="11111") then--Si es un registro de entrada (r[24] - r[31])
				Rs1Integer <= conv_integer(Rs1)-(conv_integer(cwp)*16);
		elsif(Rs1>="10000" and Rs1<="10111") then--Si es un registro de local (r[16] - r[23])
				Rs1Integer <= conv_integer(Rs1)+(conv_integer(cwp)*16);
		elsif(Rs1>="01000" and Rs1<="01111") then--Si es un registro de salida (r[8] - r[15])
				Rs1Integer <= conv_integer(Rs1)+ (conv_integer(cwp)*16);
		elsif(Rs1>="00000" and Rs1<="00111") then--Si es un registro global (r[0] - r[7])
				Rs1Integer <= conv_integer(Rs1);
		end if;
		
		if(Rs2>="11000" and Rs2<="11111") then--Si es un registro de entrada (r[24] - r[31])
				Rs2Integer <= conv_integer(Rs2)-(conv_integer(cwp)*16);
		elsif(Rs2>="10000" and Rs2<="10111") then--Si es un registro de local (r[16] - r[23])
				Rs2Integer <= conv_integer(Rs2)+(conv_integer(cwp)*16);
		elsif(Rs2>="01000" and Rs2<="01111") then--Si es un registro de salida (r[8] - r[15])
				Rs2Integer <= conv_integer(Rs2)+ (conv_integer(cwp)*16);
		elsif(Rs2>="00000" and Rs2<="00111") then--Si es un registro global (r[0] - r[7])
				Rs2Integer <= conv_integer(Rs2);
		end if;
		
		if(Rd>="11000" and Rd<="11111") then--Si es un registro de entrada (r[24] - r[31])
				RdInteger <= conv_integer(Rd)-(conv_integer(ncwp_signal)*16);
		elsif(Rd>="10000" and Rd<="10111") then--Si es un registro de local (r[16] - r[23])
				RdInteger <= conv_integer(Rd)+(conv_integer(ncwp_signal)*16);
		elsif(Rd>="01000" and Rd<="01111") then--Si es un registro de salida (r[8] - r[15])
				RdInteger <= conv_integer(Rd)+ (conv_integer(ncwp_signal)*16);
		elsif(Rd>="00000" and Rd<="00111") then--Si es un registro global (r[0] - r[7])
				RdInteger <= conv_integer(Rd);
		end if;
			
	end process;
	nRs1 <= conv_std_logic_vector(Rs1Integer, 6);
	nRs2 <= conv_std_logic_vector(Rs2Integer, 6);
	nRd <= conv_std_logic_vector(RdInteger, 6);
	nCWP <= ncwp_signal;
end Behavioral;

