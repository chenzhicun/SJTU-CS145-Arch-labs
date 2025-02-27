`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Shanghai Jiao Tong University
// Engineer: Zhicun Chen
// 
// Create Date: 2020/05/29 19:52:27
// Design Name: 
// Module Name: Registers
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


module Registers(
    input [25:21] readReg1,
    input [20:16] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    output reg [31:0] readData1,
    output reg [31:0] readData2,
    input Clk
    );
    
    reg [31:0] regFile[31:0];
    
    always @ (readReg1 or readReg2 or writeReg)
    begin
        // For the MIPS ISA, we always have reg file #0's value equals to 0;
        regFile[0]=0;
        readData1=regFile[readReg1];
        readData2=regFile[readReg2];
    end
    
    always @ (negedge Clk)
    begin
        if(regWrite)
            regFile[writeReg]=writeData;
    end
    
endmodule
