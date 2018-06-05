----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:13:56 06/05/2018 
-- Design Name: 
-- Module Name:    Execute - Behavioral 
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

entity Execute is
    Port ( Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           AluOP : in  STD_LOGIC_VECTOR (5 downto 0);
           --wrenmem : in  STD_LOGIC;
			  --outwrenmem : out  STD_LOGIC;
           --rfsource : in  STD_LOGIC_VECTOR (1 downto 0);
			  --outrfsource : out  STD_LOGIC_VECTOR (1 downto 0);
           --pc : in  STD_LOGIC_VECTOR (31 downto 0);
			  --outpc : out  STD_LOGIC_VECTOR (31 downto 0);
           nCWP : in  STD_LOGIC_VECTOR (4 downto 0);
           AluR : out  STD_LOGIC_VECTOR (31 downto 0);
           --cRd : in  STD_LOGIC_VECTOR (31 downto 0);
			  --outcRd : out  STD_LOGIC_VECTOR (31 downto 0);
           CWP : out  STD_LOGIC_VECTOR (4 downto 0);
           icc : out  STD_LOGIC_VECTOR (3 downto 0);
			  clk : in std_logic;
			  rst : in std_logic);
end Execute;



architecture Behavioral of Execute is

component ALU is
    Port ( CRs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           CRs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_OP : in  STD_LOGIC_VECTOR (5 downto 0);
           Carry : in  STD_LOGIC;
           ALU_Result : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component PSR_modifier is
    Port ( OP3 : in  STD_LOGIC_VECTOR (5 downto 0);
           ALU_result : in  STD_LOGIC_VECTOR (31 downto 0);
           bRs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           bRs2 : in  STD_LOGIC_VECTOR (31 downto 0);
			  NZVC : out  STD_LOGIC_VECTOR (3 downto 0) := "0000");
end component;

component psr is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           ncwp : in  STD_LOGIC_VECTOR (4 downto 0);
           cwp : out  STD_LOGIC_VECTOR (4 downto 0);
           carry : out  STD_LOGIC;
			  icc : out std_logic_vector (3 downto 0));
end component;

signal sAluR: std_logic_vector(31 downto 0);
signal sNZVC: std_logic_vector(3 downto 0);
signal sCarry: std_logic;





begin

	Inst_ALU: ALU PORT MAP(
		CRs1 => Op1,
		CRs2 => Op2,
		ALU_OP => AluOp,
		Carry => sCarry,
		ALU_Result => sAluR 
	);
	
	Inst_PSR_modifier: PSR_modifier PORT MAP(
		OP3 => AluOp,
		ALU_result => sAluR,
		bRs1 => Op1,
		bRs2 => Op2,
		NZVC => sNZVC
	);
	
	Inst_psr: psr PORT MAP(
		clk => clk,
		reset => rst,
		nzvc => sNZVC,
		ncwp => nCWP,
		cwp => CWP,
		carry => sCarry,
		icc => icc
	);
	

	alur <= sAluR;
--	outwrenmem <= wrenmem;
	--outpc <= pc;
	--outCrd <= Crd;
	--outrfsource <= rfsource;


end Behavioral;


