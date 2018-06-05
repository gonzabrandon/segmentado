----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:22:50 06/05/2018 
-- Design Name: 
-- Module Name:    Memory - Behavioral 
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

entity Memory is
    Port ( we : in  STD_LOGIC;
           --pc : inout  STD_LOGIC_VECTOR (31 downto 0);
--			  pc : in  STD_LOGIC_VECTOR (31 downto 0);
--			  pcO : out  STD_LOGIC_VECTOR (31 downto 0);
           --address : inout  STD_LOGIC_VECTOR (31 downto 0);
			  address : in  STD_LOGIC_VECTOR (31 downto 0);
--			  addressO : out  STD_LOGIC_VECTOR (31 downto 0);
           crd : in  STD_LOGIC_VECTOR (31 downto 0);
           --rfsource : inout  STD_LOGIC_VECTOR (1 downto 0);
--			  rfsource : in  STD_LOGIC_VECTOR (1 downto 0);
--			  rfsourceO : out  STD_LOGIC_VECTOR (1 downto 0);
           Datatomem : out  STD_LOGIC_VECTOR (31 downto 0));
end Memory;

architecture Behavioral of Memory is

	COMPONENT DM
	PORT(
		CRd : IN std_logic_vector(31 downto 0);
		addressDM : IN std_logic_vector(31 downto 0);
		wrenmem : IN std_logic;          
		data : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

begin


	Inst_DataMemory: DM PORT MAP(
		CRd => crd,
		addressDM => address,
		wrenmem => we,
		data => Datatomem
	);
	
--	pcO<=pc;
--	addressO<=address;
--	rfsourceO<=rfsource;

end Behavioral;