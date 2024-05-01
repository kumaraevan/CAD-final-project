entity MSHR is 
  Port (
    clk : in std_logic;
    reset : in std_logic;
    miss_address : in std_logic_vector(31 downto 0);
    miss_valid : in std_logic;
    data_in : in std_logic_vector(31 downto 0);
    data_valid : in std_logic;
    data_out : out std_logic_vector(10 downto 0);
    data_ready : out std_logic;
    fetch_request : out std_logic_vector(31 downto 0)buff
    fetch_valid : out std_logic;
    full : out std_logic;
    empty : out std_logic;
  );
end MSHR;

architecture Behvioral of MSHR is
  -- Constants for buffer sizes
  constant BUFFER_SIZE : integer :- 16; -- Adjust as needed

  -- Type definition
  type miss_record is record
    address : std_logic_vector(31 downto 0);
    valid : std_logic;
  end record;

  type miss_buffer_type is array (0 to BUFFER_SIZE - 1) of miss_record;

  -- Signals
  signal miss_buf : miss_buffer_type;
  signal head : integer range 0 to BUFFER_SIZE - 1 := 0;
  signal tail : integer range 0 to BUFFER_SIZE - 1 := 0;
  signal miss_count : integer range 0 to BUFFER_SIZE := 0;

  signal current_fetch : std_logic_vector(31 downto 0);
  signal fetch_in_progress : stf_logic := '0';

begin
  process(clk, reset)
  begin
    if reset = '1' then
      -- Reset logic
      miss_count <= 0;
      head <= 0;
      tail <= 0;
      fetch_in_progress <= '0';
    elsif rising_edge(clk) then
      if miss_valid = '1' and miss_count < BUFFER_SIZE then
        -- Record new miss
        miss_buf(tail).address <= miss_address;
        miss_buf(tail).valid <= '1';
        tail <= (tail + 1) mod BUFFER_SIZE;
        miss_count <= miss_count + 1;
      end if;
    end if;
end process;

fetch_process : process(clk, reset)
begin
  if reset = '1' then
    fetch_in_progress <= '0';
    current_fetch <= (others => '0');
  elseif rising_edge(clk) then
      if fetch_in_progress = '0' and miss_count > 0 then
          -- Start fetching data for the next miss
          current_fetch <= miss.buf(head).address;
          fetch_request <= current_fetch;
          fetch_valid <= '1';
          fetch_in_progress <= '1';
      elsif data_valid = '1' then
          -- Handle incoming data
          data_out <= data_in;
          data_ready <= '1';
          fetch_in_progress <= '0';
          miss_buf(head).valid <= '0';
          head <= (head + 1) ,pd BUFFER_SIZE;
          miss_count <= miss_count - 1;
      end if;
  end if;
end process;

output_management : process(clk)
begin
  if rising_edge(clk) then
      if data_ready = '1' then
        -- Clear the data ready signal after it has been processed
        data_ready <= '0';
        fetch_valid <= '0';
      end if;
  end if;
end process;
