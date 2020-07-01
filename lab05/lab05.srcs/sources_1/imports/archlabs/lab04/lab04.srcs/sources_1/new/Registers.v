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
    input Clk,
    input reset
    );

    reg [31:0] regFile[31:0];
    //declaration must be global
    reg [5:0] cnt;//we need to set bit width to 6,because if it is only 5(range:0~31), it will overflow when adding to 32
    
    always @ (readReg1 or readReg2 or writeReg)
    // actually here exists a bug that if two inst don't change the port, it will not update the read value.
    begin
        // For the MIPS ISA, we always have reg file #0's value equals to 0;
        regFile[0]=0;
        readData1=regFile[readReg1];
        readData2=regFile[readReg2];
    end
    
    always @ (negedge Clk)
    begin
        if(reset)
        begin
            for(cnt=0;cnt<32;cnt=cnt+1)
                regFile[cnt]=0;
        end
        else if(regWrite)
            regFile[writeReg]=writeData;
    end
    
endmodule
