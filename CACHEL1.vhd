LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY CACHEL1 IS
	PORT (
		I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
		O1, O2 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
		O3, O4 : OUT STD_ULOGIC;
		C1, C2 : IN STD_ULOGIC);
END CACHEL1;

ARCHITECTURE CACHEL11 OF CACHEL1 IS
	TYPE MEMORY IS ARRAY (0 TO 31) OF STD_ULOGIC_VECTOR(59 DOWNTO 0); -- array[32][60]
	SIGNAL M1 : MEMORY := (OTHERS => (OTHERS => '0'));
	SIGNAL D1, D2, R2, R3 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL D3, D4, HIT, READY : STD_ULOGIC := '0';
BEGIN
	D1 <= TRANSPORT I1 AFTER 13 ns; --address (TAG&POINTER)
	D2 <= TRANSPORT I2 AFTER 13 ns; --Write Data
	D3 <= TRANSPORT C1 AFTER 13 ns; --MemWrite
	D4 <= TRANSPORT C2 AFTER 13 ns; --MemRead

	-- D1(4 downto 0) 5 bit di pointer (32 indirizzi possibili nella cache) !! offset non presente
	-- D1(31 downto 5) 27 bit di tag (istruzione)
	-- R1(58 downto 32) 27 bit di tag
	-- R1(59) valid

	Control : PROCESS (D1, D2, D3, D4)
		VARIABLE MEMDATA : STD_ULOGIC_VECTOR(59 DOWNTO 0) := (OTHERS => '0');
		VARIABLE VALIDFLAG, TAGFLAG, HITFLAG, READYFLAG : STD_ULOGIC := '0';
	BEGIN
		IF (to_integer(unsigned(D1(4 DOWNTO 0))) < 32) THEN
			MEMDATA := M1(to_integer(unsigned(D1(4 DOWNTO 0))));
			VALIDFLAG := MEMDATA(59);
		END IF;

		IF (D1(31 DOWNTO 5) = MEMDATA(58 DOWNTO 32)) THEN
			TAGFLAG := '1';
		ELSE
			TAGFLAG := '0';
		END IF;

		IF (D3 = '0' AND D4 = '0' AND MEMDATA = "000000000000000000000000000000000000000000000000000000000000") THEN
			HITFLAG := '1';
		ELSE
			HITFLAG := VALIDFLAG AND TAGFLAG;
		END IF;

		READYFLAG := '0';

		IF (D3 = '0' AND D4 = '1') THEN --lettura
			IF (HITFLAG = '1') THEN --prendi il dato dalla cache
				R2 <= MEMDATA(31 DOWNTO 0);
				READYFLAG := '1';
			ELSE --metti in uscita l'indirizzo del dato da prendere in memoria
				R2 <= D1;
				READYFLAG := '1';
			END IF;
		ELSE
			IF (D3 = '1' AND D4 = '0') THEN --scrittura
				IF (VALIDFLAG = '0') THEN --scrivo il dato nella cache (ho hit = '0' in quanto il dato precedente � NON valido)
					M1(to_integer(unsigned(D1(4 DOWNTO 0)))) <= '1' & D1(31 DOWNTO 5) & D2;
					HITFLAG := '1';
					READYFLAG := '1';
				ELSE
					IF (VALIDFLAG = '1') THEN
						IF (HITFLAG = '1') THEN --aggiorno il dato
							M1(to_integer(unsigned(D1(4 DOWNTO 0)))) <= '1' & D1(31 DOWNTO 5) & D2; --dato valido, stesso tag, nuovo dato
							READYFLAG := '1';
						ELSE --tag non corrispondenti -> write back
							R3 <= MEMDATA(31 DOWNTO 0); --dato da scrivere in memoria write-back
							R2 <= MEMDATA(58 DOWNTO 32) & D1(4 DOWNTO 0);
							M1(to_integer(unsigned(D1(4 DOWNTO 0)))) <= '1' & D1(31 DOWNTO 5) & D2; --dato valido, diverso tag, nuovo dato
							READYFLAG := '1';
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
		HIT <= HITFLAG;
		READY <= READYFLAG;
	END PROCESS;

	O1 <= R2; --dato letto o indirizzo da leggere in memoria o indirizzo dove scrivere il write back
	O2 <= R3; --dato da scrivere in memoria (write back)
	O3 <= HIT; --hit
	O4 <= READY; --ready

END CACHEL11;