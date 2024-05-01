--**********************************************************
--*   PIPELINE REGISTERS: INSTRUCTION DECODE - EXECUTION   *
--*							   *
--*   - X7 -> RegDst		X			   *
--*   - X8 -> Jump		XX	                   *
--*   - X9 -> Branch		XX	                   *
--*   - X10 -> MemtoReg		XXX	                   *
--*   - X11 -> ALUSrc		X			   *
--*   - X12 -> MemRead		XX			   *
--*   - X13 -> MemWrite		XX			   *
--*   - X14 -> RegWrite		XXX			   *
--*   - X15 -> ALUOp		X			   *
--**********************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY IDEX IS
	PORT (
		I1, I2, I3, I4 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
		I5, I6, IA1 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0);
		I7, I8, I9, I10, I11, I12, I13, I14 : IN STD_ULOGIC;
		I15 : IN STD_ULOGIC_VECTOR(2 DOWNTO 0);
		O1, O2, O3, O4 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
		O5, O6, OA1 : OUT STD_ULOGIC_VECTOR(4 DOWNTO 0);
		O7, O8, O9, O10, O11, O12, O13, O14 : OUT STD_ULOGIC;
		O15 : OUT STD_ULOGIC_VECTOR(2 DOWNTO 0);
		C1, clk : IN STD_ULOGIC);
END IDEX;

ARCHITECTURE IDEX1 OF IDEX IS
	SIGNAL D1, D2, D3, D4 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D5, D6, D16 : STD_ULOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D7, D8, D9, D10, D11, D12, D13, D14, D17 : STD_ULOGIC := '0';
	SIGNAL D15 : STD_ULOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
BEGIN
	D17 <= C1;

	pc : PROCESS (clk)
	BEGIN
		IF (clk = '1' AND clk'event AND D17 = '1') THEN
			D1 <= I1;
			D2 <= I2;
			D3 <= I3;
			D4 <= I4;
			D5 <= I5;
			D6 <= I6;
			D7 <= I7;
			D8 <= I8;
			D9 <= I9;
			D10 <= I10;
			D11 <= I11;
			D12 <= I12;
			D13 <= I13;
			D14 <= I14;
			D15 <= I15;
			D16 <= IA1;
		END IF;
	END PROCESS;

	O1 <= D1;
	O2 <= D2;
	O3 <= D3;
	O4 <= D4;
	O5 <= D5;
	O6 <= D6;
	O7 <= D7;
	O8 <= D8;
	O9 <= D9;
	O10 <= D10;
	O11 <= D11;
	O12 <= D12;
	O13 <= D13;
	O14 <= D14;
	O15 <= D15;
	OA1 <= D16;
END IDEX1;