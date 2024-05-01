LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY HDU IS
	PORT (
		I1 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
		I2 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0);
		I3 : IN STD_ULOGIC;
		O1, O2, O3 : OUT STD_ULOGIC);
END HDU;

ARCHITECTURE HDU1 OF HDU IS
	SIGNAL D1, D2, D3 : STD_ULOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D4, R1, R2 : STD_ULOGIC;
BEGIN
	D1 <= I1(25 DOWNTO 21); --rs (registro dove prendere l'indirizzo della memoria (+ valore costante))
	D2 <= I1(20 DOWNTO 16); --rt (indirizzo del registro dove viene caricato il dato dalla memoria)
	D3 <= I2; --rt (indirizzo del registro dove viene caricato il dato dell'istruzione precedente)
	D4 <= I3; --MemRead

	R1 <= '0' WHEN (D1 /= D3 AND D2 /= D3) OR D4 = '0' ELSE
		'1' WHEN (D1 = D3 OR D2 = D3) AND D4 = '1';
	R2 <= '0' WHEN (D1 = D3 OR D2 = D3) AND D4 = '1' ELSE
		'1' WHEN (D1 /= D3 AND D2 /= D3) OR D4 = '0';

	O1 <= R1; --MUXctrl
	O2 <= R2; --PCEnable
	O3 <= R2; --IFIDEnable
END HDU1;