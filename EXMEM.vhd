--**********************************************
--*   PIPELINE REGISTERS: EXECUTION - MEMORY   *
--*   (X4 - X6 - X7 - X11 - X15 REMOVED)       *
--*					       *
--*   - X8 -> Jump		X	       *
--*   - X9 -> Branch		X	       *
--*   - X10 -> MemtoReg		XX	       *
--*   - X12 -> MemRead		X	       *
--*   - X13 -> MemWrite		X	       *
--*   - X14 -> RegWrite		XX	       *
--**********************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY EXMEM IS
	PORT (
		I1, I2, I3 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
		I5 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0);
		I8, I9, I10, I12, I13, I14, I15 : IN STD_ULOGIC;
		O1, O2, O3 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
		O5 : OUT STD_ULOGIC_VECTOR(4 DOWNTO 0);
		O8, O9, O10, O12, O13, O14, O15 : OUT STD_ULOGIC;
		C1, clk : IN STD_ULOGIC);
END EXMEM;

ARCHITECTURE EXMEM1 OF EXMEM IS
	SIGNAL D1, D2, D3 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D5 : STD_ULOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D8, D9, D10, D12, D13, D14, D15, D17 : STD_ULOGIC := '0';
BEGIN
	D17 <= C1;

	pc : PROCESS (clk)
	BEGIN
		IF (clk = '1' AND clk'event AND D17 = '1') THEN
			D1 <= I1;
			D2 <= I2;
			D3 <= I3;
			D5 <= I5;
			D8 <= I8;
			D9 <= I9;
			D10 <= I10;
			D12 <= I12;
			D13 <= I13;
			D14 <= I14;
			D15 <= I15;
		END IF;
	END PROCESS;

	O1 <= D1;
	O2 <= D2;
	O3 <= D3;
	O5 <= D5;
	O8 <= D8;
	O9 <= D9;
	O10 <= D10;
	O12 <= D12;
	O13 <= D13;
	O14 <= D14;
	O15 <= D15;

END EXMEM1;