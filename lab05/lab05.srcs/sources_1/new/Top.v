`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Shanghai Jiao Tong University
// Engineer: Zhicun Chen
// 
// Create Date: 2020/06/02 17:16:53
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

    wire REG_DST,
        JUMP,
        BRANCH,
        MEM_READ,
        MEM_TO_REG,
        MEM_WRITE,
        JR,
        JAL;
    wire [1:0] ALU_OP;
    wire ALU_SRC,
        REG_WRITE;
    reg [31:0] PC;
    wire [31:0] INST;
    // register
    wire [31:0] REG_READ_DATA_1,REG_READ_DATA_2,REG_WRITE_DATA;
    wire [4:0] WRITE_REG,WRITE_REG_FINAL;
    // ALU
    wire [31:0] IMMIDIATE_EXT,ALU_SRC_2,ALU_RESULT;
    wire [3:0] ALU_CTR_OUT;
    wire ZERO;
    // data memory
    wire [31:0] MEM_READ_DATA,REG_WRITE_DATA_FINAL;
    // PC
    wire [31:0] PC_PLUS_4,BRANCH_ADDR,JUMP_ADDR,BRANCH_MUX_RESULT,NEXT_PC,NEXT_PC_FINAL;
    wire BRANCH_FINAL;

    //main control
    Ctr mainCtr(.opCode(INST[31:26]),.regDst(REG_DST),.aluSrc(ALU_SRC),.memToReg(MEM_TO_REG),.regWrite(REG_WRITE),.memRead(MEM_READ),.memWrite(MEM_WRITE),.branch(BRANCH),.aluOp(ALU_OP),.jump(JUMP),.jal(JAL));
    //instruction memory
    instMemory instMem(.readAddress(PC),.inst(INST));

    //register files
    
    Mux5 writeRegMux(.sel(REG_DST),.in1(INST[20:16]),.in2(INST[15:11]),.out(WRITE_REG));
    Mux5 jalAddrMux(.sel(JAL),.in1(WRITE_REG),.in2(31),.out(WRITE_REG_FINAL));
    Registers regfiles(.readReg1(INST[25:21]),.readReg2(INST[20:16]),.writeReg(WRITE_REG_FINAL),.writeData(REG_WRITE_DATA_FINAL),
                        .regWrite(REG_WRITE),.readData1(REG_READ_DATA_1),.readData2(REG_READ_DATA_2),.Clk(Clk),.reset(reset));

    //ALU
    
    signext ext(.inst(INST[15:0]),.data(IMMIDIATE_EXT));
    ALU_Ctr aluCtr(.funct(INST[5:0]),.aluOp(ALU_OP),.aluCtrOut(ALU_CTR_OUT),.jr(JR));
    Mux32 aluSrcMux(.sel(ALU_SRC),.in1(REG_READ_DATA_2),.in2(IMMIDIATE_EXT),.out(ALU_SRC_2));
    ALU alu(.input1(REG_READ_DATA_1),.input2(ALU_SRC_2),.aluCtrOut(ALU_CTR_OUT),.immediate(INST[10:6]),.zero(ZERO),.aluRes(ALU_RESULT));

    //data memory
    
    dataMemory dataMem(.Clk(Clk),.address(ALU_RESULT),.writeData(REG_READ_DATA_2),.memWrite(MEM_WRITE),.memRead(MEM_READ),.readData(MEM_READ_DATA));
    Mux32 regWriteSrcMux(.sel(MEM_TO_REG),.in1(ALU_RESULT),.in2(MEM_READ_DATA),.out(REG_WRITE_DATA));
    Mux32 jalWriteMux(.sel(JAL),.in1(REG_WRITE_DATA),.in2(PC_PLUS_4),.out(REG_WRITE_DATA_FINAL));

    //compute next PC
    
    //Actually the next line can be implemented as an independent component as adder.
    assign BRANCH_FINAL=ZERO & BRANCH;
    assign PC_PLUS_4=PC+4;
    assign BRANCH_ADDR=PC_PLUS_4+(IMMIDIATE_EXT<<2);
    assign JUMP_ADDR={PC_PLUS_4[31:28],INST[25:0]<<2};
    Mux32 branchMux(.sel(BRANCH_FINAL),.in1(PC_PLUS_4),.in2(BRANCH_ADDR),.out(BRANCH_MUX_RESULT));
    Mux32 jumpMux(.sel(JUMP),.in1(BRANCH_MUX_RESULT),.in2(JUMP_ADDR),.out(NEXT_PC));
    Mux32 jrMux(.sel(JR),.in1(NEXT_PC),.in2(REG_READ_DATA_1),.out(NEXT_PC_FINAL));

    //update PC
    always @ (posedge Clk)
    begin
        if (reset)
            PC<=8'h00000000;
        else
            PC<=NEXT_PC_FINAL; 
    end

endmodule
