--*******************************************
--*   ALU CONTROL                           *
--*                                         *
--* --ALU operations-(2^3 = 8)------------- *
--*                                         *
--*   . 000 => sum                          *
--*   . 001 => subtract                     *
--*   . 010 => and                          *
--*   . 011 => or                           *
--*   . 100 => nor                          *
--*   . 101 => logical left shift           *
--*   . 110 => logical right shift          *
--*   . 111 => *2^16                        *
--*                                         *
--* --Instruction code (OP)---------------- *
--*                                         *
--*   . 100000 => R                         *
--*   . 000001 => arithmetic I (sum)        *
--*   . 000010 => data transfer I load      *
--*   . 000011 => data transfer I store     *
--*   . 000100 => logical I (and)           *
--*   . 000101 => logical I (or)            *
--*   . 000110 => logical I (shift left)    *
--*   . 000111 => logical I (shift right)   *
--*   . 001000 => conditional branch J      *
--*   . 010000 => unconditional jump J      *
--*   . others => none                      *
--*                                         *
--* --Instruction code-(ALUOP)------------- *
--*                                         *
--*   . 000 => R                            *
--*   . 001 => I sum (arith-data transfer)  *
--*   . 010 => logical I (and)              *
--*   . 011 => logical I (or)               *
--*   . 100 => logical I (sl)               *
--*   . 101 => logical I (sr)               *
--*   . 110 => conditional branch           *
--*   . 111 => unconditional jump           *
--*   . others => none                      *
--*                                         *
--* --Instruction code-(R type -> funct)--- *
--*                                         *
--*   .Arithmetic                           *
--*   . 000000 => add                       *
--*   . 000001 => subtract                  *
--*                                         *
--*   .Logical                              *
--*   . 000010 => and                       *
--*   . 000011 => or                        *
--*   . 000100 => nor                       *
--*                                         *
--*******************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ALUC IS
	PORT (
		I1 : IN STD_ULOGIC_VECTOR(2 DOWNTO 0);
		I2 : IN STD_ULOGIC_VECTOR(5 DOWNTO 0);
		O1 : OUT STD_ULOGIC_VECTOR(2 DOWNTO 0));
END ALUC;

ARCHITECTURE ALUC1 OF ALUC IS
	SIGNAL D1 : STD_ULOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D2 : STD_ULOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D3 : STD_ULOGIC_VECTOR(8 DOWNTO 0) := (OTHERS => '0');
	SIGNAL R1 : STD_ULOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
BEGIN
	D1 <= I1; --ALUOp
	D2 <= I2; --funct

	R1 <= "000" WHEN D1 = "000" AND D2 = "000000" ELSE --arithmetic sum R
		"001" WHEN D1 = "000" AND D2 = "000001" ELSE --arithmetic subtract R
		"000" WHEN D1 = "001" ELSE --memory sum I
		"010" WHEN D1 = "000" AND D2 = "000010" ELSE --logical and R      
		"011" WHEN D1 = "000" AND D2 = "000011" ELSE --logical or R
		"100" WHEN D1 = "000" AND D2 = "000100" ELSE --logical nor R
		"010" WHEN D1 = "010" ELSE --logical and I
		"011" WHEN D1 = "011" ELSE --logical or I
		"101" WHEN D1 = "100" ELSE --logical left shift I
		"110" WHEN D1 = "101" ELSE --logical right shift I
		"001" WHEN D1 = "110"; --conditional branch subtract (it is implemented only the branch on equal)

	O1 <= R1;
END ALUC1;