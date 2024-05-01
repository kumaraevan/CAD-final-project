LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY REG IS
	PORT (
		-- R-Type Instruction
		I1 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0); -- rs, 1st source register
		I2 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0); -- rt, 2nd source register
		I3 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0); -- rd, destination register
		I4 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0); -- the data that would be written in the register
		C1 : IN STD_ULOGIC; -- write register status, if it is 1, write operation would be triggered
		O1, O2 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0));
END REG;

ARCHITECTURE REG1 OF REG IS
	TYPE REGISTERFILE IS ARRAY (0 TO 31) OF STD_ULOGIC_VECTOR(31 DOWNTO 0); -- 32 register of 32 bit
	SIGNAL M1 : REGISTERFILE := (OTHERS => (OTHERS => '0'));
	SIGNAL D1, D2, D3 : STD_ULOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D4 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D5 : STD_ULOGIC := '0';
	SIGNAL R1, R2 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
BEGIN

	D1 <= I1;
	D2 <= I2;
	D3 <= I3;
	D4 <= I4;
	D5 <= C1;

	R1 <= M1(to_integer(unsigned(D1)));
	R2 <= M1(to_integer(unsigned(D2)));

	M1(to_integer(unsigned(D3))) <= D4 WHEN (D5 = '1' AND D4 /= STD_ULOGIC_VECTOR(to_signed(-1, 32)));

	O1 <= R1;
	O2 <= R2;
END REG1;