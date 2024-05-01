--*******************************************
--*   CONTROL UNIT                          *
--*                                         *
--*   ALU operations (2^3 = 8):             *
--*   . 000 => sum                          *
--*   . 001 => subtract                     *
--*   . 010 => and                          *
--*   . 011 => or                           *
--*   . 100 => nor                          *
--*   . 101 => logical left shift           *
--*   . 110 => logical right shift          *
--*   . 111 => *2^16                        *
--*                                         *
--* --Instruction code (OP)---------------- *
--*                                         *
--*   . 100000 => R                         *
--*   . 000001 => arithmetic I (sum)        *
--*   . 000010 => data transfer I load      *
--*   . 000011 => data transfer I store     *
--*   . 000100 => logical I (and)           *
--*   . 000101 => logical I (or)            *
--*   . 000110 => logical I (shift left)    *
--*   . 000111 => logical I (shift right)   *
--*   . 001000 => conditional branch J      *
--*   . 010000 => unconditional jump J      *
--*   . others => none                      *
--*                                         *
--* --Instruction code-(ALUOP)------------- *
--*                                         *
--*   . 000 => R                   *
--*   . 001 => I sum (arith-data transfer)  *
--*   . 010 => logical I (and)              *
--*   . 011 => logical I (or)               *
--*   . 100 => logical I (sl)               *
--*   . 101 => logical I (sr)               *
--*   . 110 => conditional branch           *
--*   . 111 => unconditional jump           *
--*   . others => none                      *
--*******************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY CONTROL IS
	PORT (
		I1 : IN STD_ULOGIC_VECTOR(5 DOWNTO 0);
		O1, O2, O3, O4, O5, O7, O8, O9 : OUT STD_ULOGIC;
		O6 : OUT STD_ULOGIC_VECTOR(2 DOWNTO 0));
END CONTROL;

ARCHITECTURE CTRL1 OF CONTROL IS
	SIGNAL R1 : STD_ULOGIC_VECTOR(10 DOWNTO 0) := (OTHERS => '0');
	SIGNAL R6 : STD_ULOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D1 : STD_ULOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D4, D7, D9 : STD_ULOGIC;
BEGIN
	D1 <= I1;

	--	R1 <= (RegDst)&(Jump)&(Branch)&(MemRead)&(MemtoReg)&(ALUOp)&(MemWrite)&(ALUSrc)&(RegWrite)
	WITH D1 SELECT R1 <=
		"10000000001" WHEN "100000", --R
		"00000001011" WHEN "000001", --I sum arith
		"00011001011" WHEN "000010", --I sum load
		"00001001110" WHEN "000011", --I sum store
		"00000010011" WHEN "000100", --I and
		"00000011011" WHEN "000101", --I or
		"00000100011" WHEN "000110", --I sl
		"00000101011" WHEN "000111", --I sr
		"00100110010" WHEN "001000", --branch
		"01000111010" WHEN "010000", --jump
		"00000000000" WHEN OTHERS; --(also 000000 -> NOP)

	O1 <= R1(10); --RegDst
	O2 <= R1(9); --Jump
	O3 <= R1(8); --Branch
	O5 <= R1(6); --MemtoReg
	O8 <= R1(1); --ALUSrc
	O6 <= R1(5 DOWNTO 3); --ALUOp
	O4 <= R1(7); --MemRead
	O7 <= R1(2); --MemWrite
	O9 <= R1(0); --RegWrite

END CTRL1;