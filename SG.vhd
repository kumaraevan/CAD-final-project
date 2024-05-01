--****************************************************************
--* SIGNAL GENERATOR: *
--* Generates 4 test signals for testing the MIPS. *
--* NOTE: I set the data change values so that the variation *
--* does not occur simultaneously with the clock edge. *
--****************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY SG IS
	PORT (CLK : OUT STD_ULOGIC);
END SG;

ARCHITECTURE SG1 OF SG IS

	SIGNAL DCLK : STD_ULOGIC := '0';

BEGIN
	clkGEN : PROCESS
	BEGIN
		DCLK <= '0';
		WAIT FOR 50 ns;
		DCLK <= '1';
		WAIT FOR 50 ns;
	END PROCESS;

	CLK <= DCLK;

END SG1;