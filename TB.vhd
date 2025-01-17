LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY TB IS
END TB;

ARCHITECTURE TBMIPS OF TB IS

     COMPONENT SG IS
          PORT (CLK : OUT STD_ULOGIC);
     END COMPONENT;

     COMPONENT PC IS
          PORT (
               I1 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
               O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
               C1 : IN STD_ULOGIC;
               clk : IN STD_ULOGIC);
     END COMPONENT;

     COMPONENT IM IS
          GENERIC (N : INTEGER);
          PORT (
               I1 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
               O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0));
     END COMPONENT;

     COMPONENT REG IS
          PORT (
               I1, I2, I3 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0);
               I4 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
               C1 : IN STD_ULOGIC;
               O1, O2 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0));
     END COMPONENT;

     COMPONENT SE IS
          PORT (
               I1 : IN STD_ULOGIC_VECTOR(15 DOWNTO 0);
               O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0));
     END COMPONENT;

     COMPONENT ADDER IS
          PORT (
               I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
               O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0));
     END COMPONENT;

     COMPONENT DM IS
          PORT (
               I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
               O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
               O2 : OUT STD_ULOGIC;
               C1, C2 : IN STD_ULOGIC);
     END COMPONENT;

     COMPONENT SL IS
          GENERIC (N, M : INTEGER);
          PORT (
               I1 : IN STD_ULOGIC_VECTOR((N - 1) DOWNTO 0);
               O1 : OUT STD_ULOGIC_VECTOR((M - 1) DOWNTO 0));
     END COMPONENT;

     COMPONENT ALU IS
          PORT (
               I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
               C1 : IN STD_ULOGIC_VECTOR(2 DOWNTO 0);
               O1 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
               O2 : OUT STD_ULOGIC);
     END COMPONENT;

     COMPONENT MUX IS
          GENERIC (N : INTEGER);
          PORT (
               I1 : IN STD_ULOGIC_VECTOR((N - 1) DOWNTO 0); --0
               I2 : IN STD_ULOGIC_VECTOR((N - 1) DOWNTO 0); --1
               C1 : IN STD_ULOGIC;
               O1 : OUT STD_ULOGIC_VECTOR((N - 1) DOWNTO 0));
     END COMPONENT;

     COMPONENT ALUC IS
          PORT (
               I1 : IN STD_ULOGIC_VECTOR(2 DOWNTO 0);
               I2 : IN STD_ULOGIC_VECTOR(5 DOWNTO 0);
               O1 : OUT STD_ULOGIC_VECTOR(2 DOWNTO 0));
     END COMPONENT;

     COMPONENT CONTROL IS
          PORT (
               I1 : IN STD_ULOGIC_VECTOR(5 DOWNTO 0);
               O1, O2, O3, O4, O5, O7, O8, O9 : OUT STD_ULOGIC;
               O6 : OUT STD_ULOGIC_VECTOR(2 DOWNTO 0));
     END COMPONENT;

     COMPONENT IFID IS
          PORT (
               I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
               O1, O2 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
               C1, clk : IN STD_ULOGIC);
     END COMPONENT;

     COMPONENT IDEX IS
          PORT (
               I1, I2, I3, I4 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
               I5, I6, IA1 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0);
               I7, I8, I9, I10, I11, I12, I13, I14 : IN STD_ULOGIC;
               I15 : IN STD_ULOGIC_VECTOR(2 DOWNTO 0);
               O1, O2, O3, O4 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
               O5, O6, OA1 : OUT STD_ULOGIC_VECTOR(4 DOWNTO 0);
               O7, O8, O9, O10, O11, O12, O13, O14 : OUT STD_ULOGIC;
               O15 : OUT STD_ULOGIC_VECTOR(2 DOWNTO 0);
               C1, clk : IN STD_ULOGIC);
     END COMPONENT;

     COMPONENT EXMEM IS
          PORT (
               I1, I2, I3 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
               I5 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0);
               I8, I9, I10, I12, I13, I14, I15 : IN STD_ULOGIC;
               O1, O2, O3 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
               O5 : OUT STD_ULOGIC_VECTOR(4 DOWNTO 0);
               O8, O9, O10, O12, O13, O14, O15 : OUT STD_ULOGIC;
               C1, clk : IN STD_ULOGIC);
     END COMPONENT;

     COMPONENT MEMWB IS
          PORT (
               I1, I2 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
               I3 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0);
               I10, I14 : IN STD_ULOGIC;
               O1, O2 : OUT STD_ULOGIC_VECTOR(31 DOWNTO 0);
               O3 : OUT STD_ULOGIC_VECTOR(4 DOWNTO 0);
               O10, O14 : OUT STD_ULOGIC;
               C1, clk : IN STD_ULOGIC);
     END COMPONENT;

     COMPONENT FU IS
          PORT (
               I1, I2, I3, I4 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0);
               C1, C2 : IN STD_ULOGIC;
               O1, O2 : OUT STD_ULOGIC_VECTOR(1 DOWNTO 0));
     END COMPONENT;

     COMPONENT MUX3 IS
          GENERIC (N : INTEGER);
          PORT (
               I1 : IN STD_ULOGIC_VECTOR((N - 1) DOWNTO 0);
               I2 : IN STD_ULOGIC_VECTOR((N - 1) DOWNTO 0);
               I3 : IN STD_ULOGIC_VECTOR((N - 1) DOWNTO 0);
               C1 : IN STD_ULOGIC_VECTOR(1 DOWNTO 0);
               O1 : OUT STD_ULOGIC_VECTOR((N - 1) DOWNTO 0));
     END COMPONENT;

     COMPONENT HDU IS
          PORT (
               I1 : IN STD_ULOGIC_VECTOR(31 DOWNTO 0);
               I2 : IN STD_ULOGIC_VECTOR(4 DOWNTO 0);
               I3 : IN STD_ULOGIC;
               O1, O2, O3 : OUT STD_ULOGIC);
     END COMPONENT;

     SIGNAL i : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
     SIGNAL clk : STD_ULOGIC := '0';
     SIGNAL FOUR : STD_ULOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000100";
     SIGNAL INSTR0, INSTR1, SUM0, INSTR_ADDRESS, PCIN, SUM1, CONSTANT_VALUE0, READDATA1, READDATA2, WRITEDATA, SUM2, D1, D2, CONSTANT_VALUE1, D5, DATA_ADDRESS0, DATA_ADDRESS, D6, D7, BRANCH_ADDRESS, DATA_WRITE, D8, D9, D10, D11, D12 : STD_ULOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
     SIGNAL C : STD_ULOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
     SIGNAL JUMP_ADDRESS_28 : STD_ULOGIC_VECTOR(27 DOWNTO 0) := (OTHERS => '0');
     SIGNAL WR_ADDRESS, WR_ADDRESS0, WR_ADDRESS1, D3, D4, RS, RT, RD : STD_ULOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
     SIGNAL RegDst, Jump, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, RegDst0, Jump0, Branch0, MemRead0, MemtoReg0, MemWrite0, ALUSrc0, RegWrite0, RegDstx, Jumpx, Branchx, MemReadx, MemtoRegx, MemWritex, ALUSrcx, RegWritex, Jump1, Branch1, MemRead1, MemtoReg1, MemWrite1, RegWrite1, MemtoReg2, RegWrite2, Z0, Z1, ANDCTRL, MUXCtrl, PCEnable0, PCEnable, IFIDEnable0, IFIDEnable, PCREGEnable : STD_ULOGIC := '0';
     SIGNAL ALUOp0, ALUOpx, ALUOp, ALUCTRL : STD_ULOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
     SIGNAL EN1, EN2 : STD_ULOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
     SIGNAL MUXHDUIN, MUXHDUOUT : STD_ULOGIC_VECTOR(10 DOWNTO 0) := (OTHERS => '0');

BEGIN

     SG1 : SG PORT MAP(CLK => clk);
     PC1 : PC PORT MAP(PCIN, INSTR_ADDRESS, PCEnable, clk);
     ADD1 : ADDER PORT MAP(INSTR_ADDRESS, FOUR, SUM0);
     IM1 : IM GENERIC MAP(N => 32)
     PORT MAP(INSTR_ADDRESS, INSTR0);
     MUX1 : MUX GENERIC MAP(N => 32)
     PORT MAP(SUM0, BRANCH_ADDRESS, ANDCTRL, PCIN);

     IFID1 : IFID PORT MAP(SUM0, INSTR0, SUM1, INSTR1, IFIDEnable, clk);

     CONTROL1 : CONTROL PORT MAP(INSTR1(31 DOWNTO 26), RegDstx, Jumpx, Branchx, MemReadx, MemtoRegx, MemWritex, ALUSrcx, RegWritex, ALUOpx);
     REG1 : REG PORT MAP(INSTR1(25 DOWNTO 21), INSTR1(20 DOWNTO 16), WR_ADDRESS, WRITEDATA, RegWrite, READDATA1, READDATA2);
     SE1 : SE PORT MAP(INSTR1(15 DOWNTO 0), CONSTANT_VALUE0);

     IDEX1 : IDEX PORT MAP(SUM1, READDATA1, READDATA2, CONSTANT_VALUE0, INSTR1(20 DOWNTO 16), INSTR1(15 DOWNTO 11), INSTR1(25 DOWNTO 21), RegDst0, Jump0, Branch0, MemRead0, MemtoReg0, MemWrite0, ALUSrc0, RegWrite0, ALUOp0, SUM2, D1, D2, CONSTANT_VALUE1, D3, D4, RS, RegDst, Jump1, Branch1, MemRead1, MemtoReg1, MemWrite1, ALUSrc, RegWrite1, ALUOp, PCREGEnable, clk);
     RT <= D3;
     RD <= D4;

     MUXHDUIN <= RegDstx & Jumpx & Branchx & MemReadx & MemtoRegx & MemWritex & ALUSrcx & RegWritex & ALUOpx;
     HDU1 : HDU PORT MAP(INSTR1, RT, MemRead1, MUXCtrl, PCEnable0, IFIDEnable0);
     MUX8 : MUX GENERIC MAP(N => 11) --MUX HDU
     PORT MAP(MUXHDUIN, "00000000000", MUXCtrl, MUXHDUOUT);

     RegDst0 <= MUXHDUOUT(10);
     Jump0 <= MUXHDUOUT(9);
     Branch0 <= MUXHDUOUT(8);
     MemRead0 <= MUXHDUOUT(7);
     MemtoReg0 <= MUXHDUOUT(6);
     MemWrite0 <= MUXHDUOUT(5);
     ALUSrc0 <= MUXHDUOUT(4);
     RegWrite0 <= MUXHDUOUT(3);
     ALUOp0 <= MUXHDUOUT(2 DOWNTO 0);

     ALUC1 : ALUC PORT MAP(ALUOp, CONSTANT_VALUE1(5 DOWNTO 0), ALUCTRL);
     MUX5 : MUX3 GENERIC MAP(N => 32) --MUX SOPRA
     PORT MAP(D1, WRITEDATA, DATA_ADDRESS, EN1, D11);
     MUX6 : MUX3 GENERIC MAP(N => 32) --MUX SOTTO
     PORT MAP(D2, WRITEDATA, DATA_ADDRESS, EN2, D12);
     MUX2 : MUX GENERIC MAP(N => 32)
     PORT MAP(D12, CONSTANT_VALUE1, ALUSrc, D5);
     ALU1 : ALU PORT MAP(D11, D5, ALUCTRL, DATA_ADDRESS0, Z0);
     MUX7 : MUX GENERIC MAP(N => 5)
     PORT MAP(D3, D4, RegDst, WR_ADDRESS0);
     SL2 : SL GENERIC MAP(N => 32, M => 32)
     PORT MAP(CONSTANT_VALUE1, D6);
     ADD2 : ADDER PORT MAP(SUM2, D6, D7);

     EXMEM1 : EXMEM PORT MAP(D7, DATA_ADDRESS0, D12, WR_ADDRESS0, jump1, Branch1, MemRead1, MemtoReg1, MemWrite1, RegWrite1, Z0, BRANCH_ADDRESS, DATA_ADDRESS, DATA_WRITE, WR_ADDRESS1, jump, Branch, MemRead, MemtoReg2, MemWrite, RegWrite2, Z1, PCREGEnable, clk);

     DM1 : DM PORT MAP(DATA_ADDRESS, DATA_WRITE, D8, PCREGEnable, MemWrite, MemRead);

     ANDCTRL <= Branch AND Z1;

     MEMWB1 : MEMWB PORT MAP(D8, DATA_ADDRESS, WR_ADDRESS1, MemtoReg2, RegWrite2, D9, D10, WR_ADDRESS, MemtoReg, RegWrite, PCREGEnable, clk);

     MUX4 : MUX GENERIC MAP(N => 32)
     PORT MAP(D10, D9, MemtoReg, WRITEDATA);

     FU1 : FU PORT MAP(WR_ADDRESS1, WR_ADDRESS, RS, RT, RegWrite2, RegWrite, EN1, EN2);

     PCEnable <= PCREGEnable AND PCEnable0;
     IFIDEnable <= PCREGEnable AND IFIDEnable0;

END TBMIPS;