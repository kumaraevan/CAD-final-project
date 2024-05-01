LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY DM IS
    PORT (
        I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0); -- Existing inputs
        O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0); -- Existing output
        O2 : OUT STD_ULOGIC; -- Existing output
        C1, C2 : IN STD_ULOGIC; -- Control signals
        clk : IN std_logic; -- Clock
        reset : IN std_logic; -- Reset
        -- MSHR interface
        fetch_request : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
        fetch_valid : IN STD_ULOGIC;
        data_out : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
        data_valid : OUT STD_ULOGIC
    );
END DM;

ARCHITECTURE DM1 OF DM IS

	COMPONENT CACHEL1 IS
		PORT (
			I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
			O1, O2 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
			O3, O4 : OUT STD_ULOGIC;
			C1, C2 : IN STD_ULOGIC);
	END COMPONENT;

	COMPONENT CACHEL2 IS
		GENERIC (N : INTEGER);
		PORT (
			I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
			O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
			O2 : OUT STD_ULOGIC;
			C1, C2 : IN STD_ULOGIC);
	END COMPONENT;

	COMPONENT CC IS
		PORT (
			I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
			O1, O2 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
			O3, O4, O5, O6, O7 : OUT STD_ULOGIC;
			I3, I4, C1, C2 : IN STD_ULOGIC);
	END COMPONENT;

	COMPONENT CFC IS
		PORT (
			I1, I2, I3 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
			C1, C2, C3, C4 : IN STD_ULOGIC;
			O1, O2 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
			O3, O4 : OUT STD_ULOGIC);
	END COMPONENT;

	SIGNAL ADDRESS, WRITE_DATA, ADDRESS1, WRITE_DATA1, D3, D4, D5, D6, D7, R1 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL MEMWRITE, MEMREAD, MEMWRITE1, MEMREAD1, HIT, L1READY, HIT_D, MEMWRITE_D, MEMREAD_D, L2READY, MUXCTRL, READREADY, WRITEREADY : STD_ULOGIC := '0';
	SIGNAL data_buffer : STD_ULOGIC_VECTOR(31 DOWNTO 0); -- Buffer to hold fetched data
BEGIN
	ADDRESS <= I1; --Address
	WRITE_DATA <= I2; --Write Data
	MEMWRITE <= C1; --MemWrite
	MEMREAD <= C2; --MemRead

	--ritardi introdotti dalle memorie:
	--CACHEL1 --> 25ns
	--CACHEL2 --> 250ns

	CFC1 : CFC PORT MAP(ADDRESS, WRITE_DATA, D7, MEMWRITE, MEMREAD, L2READY, HIT, ADDRESS1, WRITE_DATA1, MEMWRITE1, MEMREAD1);
	CACHEL11 : CACHEL1 PORT MAP(ADDRESS1, WRITE_DATA1, D3, D4, HIT, L1READY, MEMWRITE1, MEMREAD1);
	CC1 : CC PORT MAP(D3, D4, D5, D6, HIT_D, MEMWRITE_D, MEMREAD_D, MUXCTRL, WRITEREADY, L1READY, HIT, MEMWRITE, MEMREAD);

	--D5 = D3 = dato letto o indirizzo da leggere in memoria
	--D6 = D4 = dato da scrivere in memoria (write back)

	CACHEL21 : CACHEL2 GENERIC MAP(N => 128)
	PORT MAP(D5, D6, D7, L2READY, MEMWRITE_D, MEMREAD_D);

	finalcontrol : PROCESS (L1READY, L2READY, D3, D7, MUXCTRL, MEMREAD, MEMREAD_D)
	BEGIN
		IF (MEMREAD = '1') THEN
			IF (L1READY = '1' AND MUXCTRL = '1') THEN
				R1 <= D3;
				READREADY <= '1';
			ELSE
				IF (MEMREAD_D = '1' AND L2READY = '1' AND MUXCTRL = '0') THEN
					R1 <= D7;
					READREADY <= '1';
				ELSE
					READREADY <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS;

	mshr_fetch_process : PROCESS (clk. reset)
	BEGIN
	    IF reset = '1' THEN
		data_out <= (others => '0');
		data_valid <= '0';
	    ELSIF rising_edge(clk) THEN
		IF fetch_valid <= '0';
		    -- Simulate fetching data from memory or lower cache level
		    -- This is where the actual memory fetch logic is integrated
		    data_buffer <= fetch_request;
		    data_valid <= '1';
		    data_out <= data_buffer;
		ELSE
		    data_valid <= '0';
		END IF;
	    END IF;
	END PROCESS;

		    
	O1 <= R1;
	O2 <= '1' WHEN (MEMREAD = '0' AND MEMWRITE = '0') ELSE
		READREADY OR WRITEREADY; --PC&REGENABLE
END DM1;
