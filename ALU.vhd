--***************************************
--*   ALU                               *
--*                                     *
--*   ALU operations (2^3 = 8):         *
--*   . 000 => sum                      *
--*   . 001 => subtract                 *
--*   . 010 => and                      *
--*   . 011 => or                       *
--*   . 100 => nor                      *
--*   . 101 => logical left shift       *
--*   . 110 => logical right shift      *
--*   . 111 => *2^16                    *
--*                                     *
--*   Inputs note:                      *
--*   .I1 is the input from registers   *
--*   .I2 is the input from mux         *
--*                                     *
--*   FlagZ note:                       *
--*   .O2 = 1 if inputs are equal       *
--*   .O2 = 0 if inputs are not equal   *
--*                                     *
--*   Brnach instruction note:          *
--*   if R1 = D1-D2 > 0 => D1 > D2      *
--*   if R1 = D1-D2 < 0 => D1 < D2      *
--***************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALU IS
	PORT (
		I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
		C1 : IN STD_ULOGIC_VECTOR(2 DOWNTO 0);
		O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
		O2 : OUT STD_ULOGIC);
END ALU;

ARCHITECTURE ALU1 OF ALU IS
	SIGNAL D1, D2 : signed(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D3 : STD_ULOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
	SIGNAL R1 : signed(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL FlagZ : STD_ULOGIC := '0';
BEGIN
	D1 <= signed(I1);
	D2 <= signed(I2);
	D3 <= C1;

	WITH D3 SELECT R1 <= D1 + D2 WHEN "000",
		D1 - D2 WHEN "001",
		D1 AND D2 WHEN "010",
		D1 OR D2 WHEN "011",
		D1 NOR D2 WHEN "100",
		D1 SLL to_integer(D2) WHEN "101",
		D1 SRL to_integer(D2) WHEN "110",
		D2 SLL 16 WHEN "111",
		to_signed(-1, 32) WHEN OTHERS;

	FlagZ <= '1' WHEN R1 = to_signed(0, 32) ELSE
		'0' WHEN R1 /= to_signed(0, 32);

	O1 <= STD_ULOGIC_VECTOR(R1);
	O2 <= FlagZ;
END ALU1;