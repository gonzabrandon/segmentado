----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:29:44 06/05/2018 
-- Design Name: 
-- Module Name:    WriteBack - Behavioral 
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

entity WriteBack is
    Port ( pc : in  STD_LOGIC_VECTOR (31 downto 0);
           datatomem : in  STD_LOGIC_VECTOR (31 downto 0);
           aluads : in  STD_LOGIC_VECTOR (31 downto 0);
           rfsource : in  STD_LOGIC_VECTOR (1 downto 0);
           datatores : out  STD_LOGIC_VECTOR (31 downto 0));
end WriteBack;

 architecture Behavioral of WriteBack is

	COMPONENT dwrMUX
	PORT(
		data : IN std_logic_vector(31 downto 0);
		alu_result : IN std_logic_vector(31 downto 0);
		pc : IN std_logic_vector(31 downto 0);
		selector : IN std_logic_vector(1 downto 0);          
		data_to_write : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

begin

Inst_muxDM: dwrMUX PORT MAP(
		data => datatomem,
		alu_result => aluads,
		pc => pc,
		selector => rfsource,
		data_to_write => datatores
	);

end Behavioral;

