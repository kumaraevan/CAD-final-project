--**********************************
--*   MULTIPLEXER                  *
--*                                *
--*   When C1 = 0 I1 is selected   *
--*   When C1 = 1 I2 is selected   *
--**********************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY MUX IS
	GENERIC (N : INTEGER);
	PORT (
		I1 : IN STD_ULOGIC_VECTOR((N - 1) DOWNTO 0);
		I2 : IN STD_ULOGIC_VECTOR((N - 1) DOWNTO 0);
		C1 : IN STD_ULOGIC;
		O1 : OUT STD_ULOGIC_VECTOR((N - 1) DOWNTO 0));
END MUX;

ARCHITECTURE MUX1 OF MUX IS
	SIGNAL D1 : STD_ULOGIC_VECTOR((N - 1) DOWNTO 0) := (OTHERS => '0');
	SIGNAL D2 : STD_ULOGIC_VECTOR((N - 1) DOWNTO 0) := (OTHERS => '0');
	SIGNAL D3 : STD_ULOGIC := '0';
	SIGNAL R1 : STD_ULOGIC_VECTOR((N - 1) DOWNTO 0) := (OTHERS => '0');
BEGIN
	D1 <= I1;
	D2 <= I2;
	D3 <= C1;
	R1 <= D1 WHEN D3 = '0' ELSE
		D2 WHEN D3 /= '0';
	O1 <= R1;
END MUX1;