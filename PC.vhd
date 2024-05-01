--***********************
--*   PROGRAM COUNTER   *
--***********************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY PC IS
	PORT (
		-- Note that: STD_ULOGIC_VECTOR(31 DOWNTO 0)
		-- Is an array with 32 elements, start from 31 to 0 for its indexes. Each element contain one bit value.
		I1 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0); -- The next program counter from the current PC as the input
		O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0); -- PC as the output
		C1 : IN STD_ULOGIC; -- PC Enable/Disable, reset
		clk : IN STD_ULOGIC -- Current clock
	);
END PC;

ARCHITECTURE PC1 OF PC IS
	SIGNAL D1 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0'); -- Default output as 32 bit with all of its value as 0
	SIGNAL D3 : STD_ULOGIC := '0'; -- Default value of PC Enable/Disable, the inizialition value is 0
BEGIN
	D3 <= C1; -- PC Enable

	pc : PROCESS (clk)
	BEGIN
		-- Return the next PC if the clock is change, and the value of it is 1, and the PC is enable
		IF (clk = '1' AND clk'event AND D3 = '1') THEN
			D1 <= I1;
		END IF;

		-- Otherwise, return the PC with 0 value
	END PROCESS;

	O1 <= D1;
END PC1;