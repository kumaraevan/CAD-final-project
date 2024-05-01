--**************************************
--*   SHIFT LEFT FROM N bit TO N bit   *
--*                                    *
--*   Shift left of 2 O1 = I1 << 2     *
--**************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY SL IS
	GENERIC (N, M : INTEGER);
	PORT (
		I1 : IN STD_ULOGIC_VECTOR((N - 1) DOWNTO 0);
		O1 : OUT STD_ULOGIC_VECTOR((M - 1) DOWNTO 0));
END SL;

ARCHITECTURE SL1 OF SL IS
	SIGNAL D1 : unsigned((N - 1) DOWNTO 0) := (OTHERS => '0');
	SIGNAL R1 : unsigned((M - 1) DOWNTO 0) := (OTHERS => '0');
BEGIN
	D1 <= unsigned(I1);

	R1 <= --D1((M-1) downto 0) when N > M else
		D1 & to_unsigned(0, M - N) WHEN N < M ELSE
		D1 WHEN N = M;
	O1 <= STD_ULOGIC_VECTOR(R1);
END SL1;