LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY MSHR_TB IS
END MSHR_TB;

ARCHITECTURE behavior OF MSHR_TB IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT MSHR
        PORT(
            clk : IN std_logic;
            reset : IN std_logic;
            miss_address : IN std_logic_vector(31 DOWNTO 0);
            miss_valid : IN std_logic;
            data_in : IN std_logic_vector(31 DOWNTO 0);
            data_valid : IN std_logic;
            data_out : OUT std_logic_vector(31 DOWNTO 0);
            data_ready : OUT std_logic;
            fetch_request : OUT std_logic_vector(31 DOWNTO 0);
            fetch_valid : OUT std_logic;
            full : OUT std_logic;
            empty : OUT std_logic
        );
    END COMPONENT;
   
    -- Signals for Inputs and Outputs
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal miss_address : std_logic_vector(31 DOWNTO 0) := (others => '0');
    signal miss_valid : std_logic := '0';
    signal data_in : std_logic_vector(31 DOWNTO 0) := (others => '0');
    signal data_valid : std_logic := '0';
    signal data_out : std_logic_vector(31 DOWNTO 0);
    signal data_ready : std_logic;
    signal fetch_request : std_logic_vector(31 DOWNTO 0);
    signal fetch_valid : std_logic;
    signal full : std_logic;
    signal empty : std_logic;

    -- Clock generation
    clk_process :process
    BEGIN
        clk <= '0';
        WAIT FOR 10 ns;
        clk <= '1';
        WAIT FOR 10 ns;
    END PROCESS;

BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: MSHR PORT MAP (
        clk => clk,
        reset => reset,
        miss_address => miss_address,
        miss_valid => miss_valid,
        data_in => data_in,
        data_valid => data_valid,
        data_out => data_out,
        data_ready => data_ready,
        fetch_request => fetch_request,
        fetch_valid => fetch_valid,
        full => full,
        empty => empty
    );

    -- Stimulus Process
    stim_proc: process
    begin       
        -- Initialize Inputs
        reset <= '1';
        WAIT FOR 20 ns;  
        reset <= '0';     
        WAIT FOR 30 ns;  

        -- Simulate a Cache Miss
        miss_address <= "00000000000000000000000000000001";
        miss_valid <= '1';
        WAIT FOR 20 ns;

        miss_valid <= '0';
        WAIT FOR 40 ns;

        -- Simulate Data Return from Memory
        data_in <= "00000000000000000000000010101010";
        data_valid <= '1';
        WAIT FOR 20 ns;

        data_valid <= '0';
        WAIT FOR 50 ns;

        -- Add more scenarios as needed
        
        -- Finish simulation
        WAIT;
    end process;

END behavior;
