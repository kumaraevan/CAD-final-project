--****************************************************************
--*   PIPELINE REGISTERS: MEMORY - WRITE BACK                    *
--*   (X4 - X6 - X7 - X8 - X9 - X11 - X12 - X13 - X15 REMOVED)   *
--*					                         *
--*   - X10 -> MemtoReg		X	                         *
--*   - X14 -> RegWrite		X	                         *
--****************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY MEMWB IS
	PORT (
		I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
		I3 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0);
		I10, I14 : IN STD_ULOGIC;
		O1, O2 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
		O3 : OUT STD_ULOGIC_VECTOR(4 DOWNTO 0);
		O10, O14 : OUT STD_ULOGIC;
		C1, clk : IN STD_ULOGIC);
END MEMWB;

ARCHITECTURE MEMWB1 OF MEMWB IS
	SIGNAL D1, D2 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D3 : STD_ULOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D10, D14, D17 : STD_ULOGIC := '0';
BEGIN
	D17 <= C1;

	pc : PROCESS (clk)
	BEGIN
		IF (clk = '1' AND clk'event AND D17 = '1') THEN
			D1 <= I1;
			D2 <= I2;
			D3 <= I3;
			D10 <= I10;
			D14 <= I14;
		END IF;
	END PROCESS;

	O1 <= D1;
	O2 <= D2;
	O3 <= D3;
	O10 <= D10;
	O14 <= D14;

END MEMWB1;