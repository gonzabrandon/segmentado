----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:32:32 06/05/2018 
-- Design Name: 
-- Module Name:    InstructionFetch - Behavioral 
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

entity InstructionFetch is
Port ( 	clk : in  STD_LOGIC;
         rst : in  STD_LOGIC;
         npc : in  STD_LOGIC_VECTOR (31 downto 0);
         instructionM : out  STD_LOGIC_VECTOR (31 downto 0);
			outSumador: out std_logic_vector(31 downto 0);
			pcO: out std_logic_vector(31 downto 0));
end InstructionFetch;

architecture Behavioral of InstructionFetch is

	COMPONENT IM
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		instruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT PC
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		PC_IN : IN std_logic_vector(31 downto 0);          
		PC_OUT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	
	signal aux_instruccion: std_logic_vector(31 downto 0);
	signal aux_npcpc: std_logic_vector(31 downto 0);
	signal aux_addressIM : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);
--signal : std_logic_vector(31 downto 0);

begin
	Inst_InstructionMemory: IM PORT MAP(
		address => aux_addressIM,
		reset => rst,
		instruction => aux_instruccion
	);
	
	Inpc: PC PORT MAP(
		clk => clk,
		rst =>rst,
		PC_IN => npc,
		PC_OUT => aux_npcpc
	);
	
	programCounter: PC PORT MAP(
		clk => clk,
		rst => rst,
		PC_IN => aux_npcpc,
		PC_OUT => aux_addressIM
	);
	pcO <= aux_addressIM;
	instructionM <= aux_instruccion;
	outSumador <= aux_npcpc;

end Behavioral;

