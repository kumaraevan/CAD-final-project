--***********************************
--*   MULTIPLEXER                   *
--*                                 *
--*   When C1 = 00 I1 is selected   *
--*   When C1 = 01 I2 is selected   *
--*   When C1 = 10 I3 is selected   *
--***********************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY MUX3 IS
	GENERIC (N : INTEGER);
	PORT (
		I1 : IN STD_ULOGIC_VECTOR((N - 1) DOWNTO 0);
		I2 : IN STD_ULOGIC_VECTOR((N - 1) DOWNTO 0);
		I3 : IN STD_ULOGIC_VECTOR((N - 1) DOWNTO 0);
		C1 : IN STD_ULOGIC_VECTOR(1 DOWNTO 0);
		O1 : OUT STD_ULOGIC_VECTOR((N - 1) DOWNTO 0));
END MUX3;

ARCHITECTURE MUX1 OF MUX3 IS
	SIGNAL D1 : STD_ULOGIC_VECTOR((N - 1) DOWNTO 0) := (OTHERS => '0');
	SIGNAL D2 : STD_ULOGIC_VECTOR((N - 1) DOWNTO 0) := (OTHERS => '0');
	SIGNAL D3 : STD_ULOGIC_VECTOR((N - 1) DOWNTO 0) := (OTHERS => '0');
	SIGNAL D4 : STD_ULOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL R1 : STD_ULOGIC_VECTOR((N - 1) DOWNTO 0) := (OTHERS => '0');
BEGIN
	D1 <= I1;
	D2 <= I2;
	D3 <= I3;
	D4 <= C1;
	R1 <= D1 WHEN D4 = "00" ELSE
		D2 WHEN D4 = "01" ELSE
		D3 WHEN D4 = "10";
	O1 <= R1;
END MUX1;