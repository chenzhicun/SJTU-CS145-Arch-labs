`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 09:15:58
// Design Name: 
// Module Name: Top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Top(
    input Clk,
    input reset
    );
    
    // define pipeline stage register
    // IF/ID
    reg [31:0] IFID_PC_PLUS_4, IFID_INST;
    wire [4:0] IFID_RS = IFID_INST[25:21], IFID_RT = IFID_INST[20:16], IFID_RD = IFID_INST[15:11];
    wire BRANCH;

    // ID/EX
    reg [31:0] IDEX_READDATA_1, IDEX_READDATA_2, IDEX_IMMI_EXT;
    reg [4:0] IDEX_RS, IDEX_RT, IDEX_RD;
    reg [11:0] IDEX_CTRL;
    wire IDEX_REG_DST = IDEX_CTRL[11], IDEX_ALU_SRC = IDEX_CTRL[10], IDEX_MEM_TO_REG = IDEX_CTRL[9],
        IDEX_REG_WRITE = IDEX_CTRL[8], IDEX_MEM_READ = IDEX_CTRL[7], IDEX_MEM_WRITE = IDEX_CTRL[6],
        IDEX_BRANCH = IDEX_CTRL[5], IDEX_JUMP = IDEX_CTRL[1], IDEX_JAL = IDEX_CTRL[0];
    wire [2:0] IDEX_ALUOP = IDEX_CTRL[4:2];

    // EX/MEM
    reg [31:0] EXMEM_ALU_RES, EXMEM_WRITE_DATA;
    reg [4:0] EXMEM_REG_DST;
    reg [4:0] EXMEM_CTRL;
    reg EXMEM_ZERO;
    wire EXMEM_MEM_TO_REG = EXMEM_CTRL[4], EXMEM_REG_WRITE = EXMEM_CTRL[3], EXMEM_MEM_READ = EXMEM_CTRL[2],
        EXMEM_MEM_WRITE = EXMEM_CTRL[1], EXMEM_BRANCH = EXMEM_CTRL[0];

    // MEM/WB
    reg [31:0] MEMWB_MEM_READ_DATA, MEMWB_ALURES;
    reg [4:0] MEMWB_REG_DST;
    reg [1:0] MEMWB_CTRL;
    wire MEMWB_MEM_TO_REG = MEMWB_CTRL[1], MEMWB_REG_WRITE = MEMWB_CTRL[0];

    // define what will be done in each stage
    // IF stage
    reg [31:0] PC;
    wire [31:0] PC_PLUS_4, BRANCH_ADDR, NEXT_PC, INST;
    assign PC_PLUS_4 = PC + 4;
    Mux32 branchMux(.sel(BRANCH),.in1(PC_PLUS_4),.in2(BRANCH_ADDR),.out(NEXT_PC));
    instMemory instMem(.readAddress(PC),.inst(INST));

    //update PC and stage register
    always @ (posedge Clk)
    begin
        if (!STALL)
        begin
            IFID_PC_PLUS_4 <= PC_PLUS_4;
            IFID_INST <= INST;
            PC <= NEXT_PC;
        end
        if (BRANCH)
        // flush the instruction;
        // we use the strategy that always predicts not taken;
        // so if we should take the branch, flush the original instruction;
        begin
            IFID_INST <= 0; 
        end
    end

    //ID stage
    wire REG_DST, ALU_SRC, MEM_TO_REG, REG_WRITE, MEM_READ, MEM_WRITE, CTR_BRANCH, JUMP, JAL;
    wire [2:0] ALU_OP;
    Ctr mainCtr(.opCode(IFID_INST[31:26]),.regDst(REG_DST),.aluSrc(ALU_SRC),.memToReg(MEM_TO_REG),.regWrite(REG_WRITE),.memRead(MEM_READ),.memWrite(MEM_WRITE),
        .branch(CTR_BRANCH),.aluOp(ALU_OP),.jump(JUMP),.jal(JAL));
    
    wire [31:0] REG_READ_DATA_1, REG_READ_DATA_2, REG_WRITE_DATA;
    Registers regfiles(.readReg1(IFID_RS),.readReg2(IFID_RT),.writeReg(MEMWB_REG_DST),.writeData(REG_WRITE_DATA),.regWrite(MEMWB_REG_WRITE),
        .readData1(REG_READ_DATA_1),.readData2(REG_READ_DATA_2),.Clk(Clk),.reset(reset));

    wire [31:0] IMMIDIATE_EXT;
    signext ID_signext(.inst(IFID_INST[15:0]),.data(IMMIDIATE_EXT));
    // solve branch instruction at ID stage
    assign BRANCH_ADDR = (IMMIDIATE_EXT << 2) + IFID_PC_PLUS_4;
    assign BRANCH = (REG_READ_DATA_1 == REG_READ_DATA_2) & CTR_BRANCH;

    always @ (posedge Clk)
    begin
        IDEX_CTRL <= STALL ? 0 : {REG_DST, ALU_SRC, MEM_TO_REG, REG_WRITE, MEM_READ, MEM_WRITE, CTR_BRANCH, ALU_OP[2:0], JUMP, JAL};
        IDEX_READDATA_1 <= REG_READ_DATA_1;
        IDEX_READDATA_2 <= REG_READ_DATA_2;
        IDEX_IMMI_EXT <= IMMIDIATE_EXT;
        IDEX_RS <= IFID_RS;
        IDEX_RT <= IFID_RT;
        IDEX_RD <= IFID_RD;
    end

    // forwarding unit
    wire FWD_EX_A = EXMEM_REG_WRITE & (EXMEM_REG_DST == IDEX_RS);
    wire FWD_EX_B = EXMEM_REG_WRITE & (EXMEM_REG_DST == IDEX_RT);
    wire FWD_MEM_A = MEMWB_REG_WRITE & (MEMWB_REG_DST == IDEX_RS);
    wire FWD_MEM_B = MEMWB_REG_WRITE & (MEMWB_REG_DST == IDEX_RT);

    // EX stage
    // using if statement to replace Mux32
    wire [31:0] ALU_SRC_A = FWD_EX_A ? EXMEM_ALU_RES : FWD_MEM_A ? REG_WRITE_DATA : IDEX_READDATA_1;
    wire [31:0] ALU_SRC_B = FWD_EX_B ? EXMEM_ALU_RES : FWD_MEM_B ? REG_WRITE_DATA : IDEX_READDATA_2;
    wire [31:0] ALU_SRC_B_FINAL;
    wire [31:0] MEM_WRITE_DATA = FWD_EX_B ? EXMEM_ALU_RES : FWD_MEM_B ? REG_WRITE_DATA :IDEX_READDATA_2;
    wire [31:0] ALU_RES;
    wire [4:0] WRITE_REG_DST;
    wire [3:0] ALU_CTR_OUT;
    wire ZERO;

    ALU_Ctr aluCtr(.funct(IDEX_IMMI_EXT[5:0]),.aluOp(IDEX_ALUOP),.aluCtrOut(ALU_CTR_OUT));
    Mux32 aluSrcMux(.sel(IDEX_ALU_SRC),.in1(ALU_SRC_B),.in2(IDEX_IMMI_EXT),.out(ALU_SRC_B_FINAL));
    ALU alu(.input1(ALU_SRC_A),.input2(ALU_SRC_B_FINAL),.aluCtrOut(ALU_CTR_OUT),
        .immediate(IDEX_IMMI_EXT[10:6]),.zero(ZERO),.aluRes(ALU_RES));

    Mux5 regDstMux(.sel(IDEX_REG_DST),.in1(IDEX_RT),.in2(IDEX_RD),.out(WRITE_REG_DST));

    always @ (posedge Clk)
    begin
        EXMEM_CTRL <= IDEX_CTRL[9:5];
        EXMEM_ZERO <= ZERO;
        EXMEM_ALU_RES <= ALU_RES;
        EXMEM_WRITE_DATA <= MEM_WRITE_DATA;
        EXMEM_REG_DST <= WRITE_REG_DST;
    end

    // MEM stage
    wire [31:0] MEM_READ_DATA;
    dataMemory dataMem(.Clk(Clk),.address(EXMEM_ALU_RES),.writeData(EXMEM_WRITE_DATA),
        .memWrite(EXMEM_MEM_WRITE),.memRead(EXMEM_MEM_READ),.readData(MEM_READ_DATA));
    
    always @ (posedge Clk)
    begin
        MEMWB_CTRL <= EXMEM_CTRL[4:3];
        MEMWB_MEM_READ_DATA <= MEM_READ_DATA;
        MEMWB_ALURES <= EXMEM_ALU_RES;
        MEMWB_REG_DST <= EXMEM_REG_DST;
    end

    // WB stage
    Mux32 writeDataMux(.sel(MEMWB_MEM_TO_REG),.in1(MEMWB_ALURES),.in2(MEMWB_MEM_READ_DATA),.out(REG_WRITE_DATA));

    always @ (reset)
    begin
        PC = 0;
        IFID_PC_PLUS_4 = 0;
        IFID_INST = 0;
        IDEX_READDATA_1 = 0;
        IDEX_READDATA_2 = 0;
        IDEX_IMMI_EXT = 0;
        IDEX_RS = 0;
        IDEX_RT = 0;
        IDEX_RD = 0;
        IDEX_CTRL = 0;
        EXMEM_ALU_RES = 0;
        EXMEM_WRITE_DATA = 0;
        EXMEM_REG_DST = 0;
        EXMEM_CTRL = 0;
        EXMEM_ZERO = 0;
        MEMWB_MEM_READ_DATA = 0;
        MEMWB_ALURES = 0;
        MEMWB_REG_DST = 0;
        MEMWB_CTRL = 0;
    end




endmodule
