--*******************
--*   SIGN EXTEND   *
--*******************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY SE IS
	PORT (
		I1 : IN STD_ULOGIC_VECTOR(15 DOWNTO 0);
		O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0));
END SE;

ARCHITECTURE SE1 OF SE IS
	SIGNAL D1 : signed(31 DOWNTO 0) := (OTHERS => '0');
BEGIN
	D1 <= resize(signed(I1), 32);
	O1 <= STD_ULOGIC_VECTOR(D1);
END SE1;