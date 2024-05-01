--***********************
--*   Forwarding Unit   *
--***********************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY FU IS
	PORT (
		I1, I2, I3, I4 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0);
		C1, C2 : IN STD_ULOGIC;
		O1, O2 : OUT STD_ULOGIC_VECTOR(1 DOWNTO 0));
END FU;

ARCHITECTURE FU1 OF FU IS
	SIGNAL D1, D2, D3, D4 : STD_ULOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D5, D6 : STD_ULOGIC := '0';
	SIGNAL R1, R2 : STD_ULOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
BEGIN

	D1 <= I1; --Write Address 1
	D2 <= I2; --Write Address
	D3 <= I3; --Rs s2
	D4 <= I4; --Rt s3 (R)
	D5 <= C1; --RegWrite2 ex/mem
	D6 <= C2; --RegWrite mem/wb

	R1 <= "10" WHEN D3 = D1 AND D5 = '1' ELSE
		"01" WHEN D3 = D2 AND D6 = '1' ELSE
		"00";

	R2 <= "10" WHEN D4 = D1 AND D5 = '1' ELSE
		"11" WHEN D4 = D2 AND D6 = '1' ELSE
		"00";
	O1 <= R1; --mux SOPRA
	O2 <= R2; --mux SOTTO 

END FU1;