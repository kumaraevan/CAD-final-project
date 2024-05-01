--******************************************************************
--*   PIPELINE REGISTERS: INSTRUCTION FETCH - INSTRUCTION DECODE   *
--******************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY IFID IS
	PORT (
		I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
		O1, O2 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
		C1, clk : IN STD_ULOGIC);
END IFID;

ARCHITECTURE IFID1 OF IFID IS
	SIGNAL D1, D2 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D3 : STD_ULOGIC := '0';
BEGIN
	D3 <= C1; --IFIDEnable

	pc : PROCESS (clk, D3)
	BEGIN
		IF (clk = '1' AND clk'event AND D3 = '1') THEN
			D1 <= I1;
			D2 <= I2;
		END IF;
	END PROCESS;

	O1 <= D1;
	O2 <= D2;
END IFID1;