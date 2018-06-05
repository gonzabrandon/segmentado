----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:36:03 06/05/2018 
-- Design Name: 
-- Module Name:    InstructionControl - Behavioral 
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

entity Control is
    Port ( 
			  pcIN : in  STD_LOGIC_VECTOR (31 downto 0);
			  npcIN : in  STD_LOGIC_VECTOR (31 downto 0);
           iccIN : in  STD_LOGIC_VECTOR (3 downto 0);
           --opIN : in  STD_LOGIC_VECTOR (1 downto 0);
           --op3IN : in  STD_LOGIC_VECTOR (5 downto 0);
           --condIN : in  STD_LOGIC_VECTOR (3 downto 0);
			  instruction : in  STD_LOGIC_VECTOR (31 downto 0);
           aluResultIN : in  STD_LOGIC_VECTOR (31 downto 0);
           --pcOUT : out  STD_LOGIC_VECTOR (31 downto 0);
           rfDestOUT : out  STD_LOGIC;
           rfSourceOUT : out  STD_LOGIC_VECTOR (1 downto 0);
           wrEnMemOUT : out  STD_LOGIC;
			  wrEnRegisOUT : out  STD_LOGIC;
           aluOpOUT : out  STD_LOGIC_VECTOR (5 downto 0);
			  npcOUT : out  STD_LOGIC_VECTOR (31 downto 0));
			  
end Control;

architecture Behavioral of Control is

	signal auxExtDisp22 : std_logic_vector(31 downto 0);
	signal auxExtDisp30 : std_logic_vector(31 downto 0);
	signal auxPcmas1 : std_logic_vector(31 downto 0);
	signal auxPcmasSeu22 : std_logic_vector(31 downto 0);
	signal auxPcmasSeu30 : std_logic_vector(31 downto 0);
	signal auxPcSource : STD_LOGIC_VECTOR (1 downto 0);
	
	COMPONENT adder1
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);          
		suma : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
		COMPONENT SEU22
	PORT(
		SEU22 : IN std_logic_vector(21 downto 0);          
		SEU32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT SEU30
	PORT(
		SEU30 : IN std_logic_vector(29 downto 0);          
		SEU32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

		COMPONENT muxPCSource
	PORT(
		PCDisp30 : IN std_logic_vector(31 downto 0);
		PCDisp22 : IN std_logic_vector(31 downto 0);
		PC1 : IN std_logic_vector(31 downto 0);
		PCAddress: IN std_logic_vector(31 downto 0);
		PCSource : IN std_logic_vector(1 downto 0);          
		PCAddressOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT UC
	PORT(
		icc : IN std_logic_vector(3 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		op : IN std_logic_vector(1 downto 0);
		op2 : IN std_logic_vector(2 downto 0);
		cond : IN std_logic_vector(3 downto 0);          
		write_enable : OUT std_logic;
		wrenDM : OUT std_logic;
		selectorDM : OUT std_logic_vector(1 downto 0);
		RFdest : OUT std_logic;
		PCSource : OUT std_logic_vector(1 downto 0);
		aluOP : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;






begin

	Inst_sumador32bitsMas1: adder1 PORT MAP(
		a => "00000000000000000000000000000001",
		b => npcin,
		suma => auxPcmas1
	);
	
	Inst_SEUdisp22: SEU22 PORT MAP(
		SEU22 => instruction(21 downto 0),
		SEU32 => auxExtDisp22
	);
	
	Inst_sumador32bitsSeu22: adder1 PORT MAP(
		a => pcIN,
		b => auxExtDisp22,
		suma => auxPcmasSeu22
	);
	
	
	Inst_SEUdisp30: SEU30 PORT MAP(
		SEU30 => instruction(29 downto 0),
		SEU32 => auxExtDisp30
	);
	
	Inst_sumador32bitsSeu30: adder1 PORT MAP(
		a => auxExtDisp30,
		b => pcIN,
		suma => auxPcmasSeu30
	);
	
		Inst_muxPC: muxPCSource PORT MAP(
		PCDisp30 => auxPcmasSeu30,
		PCDisp22 => auxPcmasSeu22,
		PC1 => auxPcmas1,
		PCAddress => aluResultIN,
		PCsource => auxPcSource,
		PCAddressOut => npcOUT
	);
	
		Inst_ControUnit: UC PORT MAP(
		icc => iccIN,
		op3 => instruction(24 downto 19),
		op => instruction(31 downto 30),
		op2 => instruction(24 downto 22),
		cond => instruction(28 downto 25),
		write_enable => wrEnRegisOUT,
		wrenDM => wrEnMemOUT,
		selectorDM => rfSourceOUT,
		RFdest => rfDestOUT,
		PCsource => auxPcSource,
		aluOP => aluOpOUT
	);
	
	
end Behavioral;

