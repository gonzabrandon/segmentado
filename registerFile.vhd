----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:43:40 10/02/2015 
-- Design Name: 
-- Module Name:    registerFile - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registerFile is
    Port ( clk : in STD_LOGIC;
			  nRs1 : in  STD_LOGIC_VECTOR(5 downto 0);
           nRs2 : in  STD_LOGIC_VECTOR(5 downto 0);
           nRd : in  STD_LOGIC_VECTOR(5 downto 0);
           wren : in  STD_LOGIC;
			  reset : in STD_LOGIC;
			  Dwr : in STD_LOGIC_VECTOR(31 downto 0);
           Crs1 : out  STD_LOGIC_VECTOR(31 downto 0);
           Crs2 : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end registerFile;

architecture syn of registerFile is
    type ram_type is array (0 to 39) of std_logic_vector (31 downto 0);
    signal RAM : ram_type := ((others=>(others=>'0')));

begin

process (clk, reset)
    begin
        if rising_edge(clk) then
            if (wren = '1' and not(nRd = "00000")) then
                RAM(conv_integer(nRd)) <= Dwr;
            end if;
        end if;
    end process;
Crs1<=RAM(conv_integer(nRs1));
Crs2<=RAM(conv_integer(nRs2));

end syn;

