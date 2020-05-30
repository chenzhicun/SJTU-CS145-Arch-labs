`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/29 21:34:37
// Design Name: 
// Module Name: Register_tb
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


module Register_tb(

    );
    reg Clk;
    reg [25:21] readReg1;
    reg [20:16] readReg2;
    reg [4:0] writeReg;
    reg [31:0] writeData;
    reg regWrite;
    
    Registers register(.readReg1(readReg1),.readReg2(readReg2),.writeReg(writeReg),.writeData(writeData),.regWrite(regWrite),.Clk(Clk));
    always #100 Clk=!Clk;

    initial begin
        // Initialize Inputs
        Clk=0;
        readReg1=0;
        readReg2=0;
        writeReg=0;
        writeData=0;
        regWrite=0;
        // There is no need to initialize register files;

        #100 Clk=0;

        // current time:285ns
        #185;
        regWrite=1'b1;
        writeReg=5'b10101;
        writeData=32'b11111111111111110000000000000000;

        // current time:485ns
        #200;
        writeReg=5'b01010;
        writeData=32'b00000000000000001111111111111111;

        //current time:685ns
        #200;
        regWrite=1'b0;
        writeReg=5'b00000;
        writeData=32'b00000000000000000000000000000000;

        //current time:735ns
        #50;
        readReg1=5'b10101;
        readReg2=5'b01010;
    end
    
endmodule
