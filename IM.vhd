
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use std.textio.all;

entity IM is
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           instruction : out  STD_LOGIC_VECTOR (31 downto 0));
end IM;

architecture Behavioral of IM is

type rom_type is array (0 to 63) of std_logic_vector (31 downto 0);
		
	impure function InitRomFromFile (RomFileName : in string) return rom_type is
		FILE RomFile : text open read_mode is RomFileName;
		variable RomFileLine : line;
		variable temp_bv : bit_vector(31 downto 0);
		variable temp_mem : rom_type;
		begin
			for I in rom_type'range loop
				readline (RomFile, RomFileLine);
				read(RomFileLine, temp_bv);
				temp_mem(i) := to_stdlogicvector(temp_bv);
			end loop;
		return temp_mem;
	end function;
	
signal instructions : rom_type := InitRomFromFile("testsuma.data");

begin
	process(reset,address, instructions)--clk)
	begin
		--if(rising_edge(clk))then
			if(reset = '1')then
				instruction <= (others=>'0');
			else
				instruction <= instructions(conv_integer(address(5 downto 0)));
			end if;
		--end if;
	end process;

end Behavioral;

