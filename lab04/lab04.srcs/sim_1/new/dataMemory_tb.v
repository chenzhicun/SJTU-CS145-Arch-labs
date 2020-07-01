`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Shanghai Jiao Tong University
// Engineer: Zhicun Chen
// 
// Create Date: 2020/05/29 23:09:50
// Design Name: 
// Module Name: dataMemory_tb
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


module dataMemory_tb(

    );

    reg Clk;
    reg [31:0] address;
    reg [31:0] writeData;
    reg memWrite;
    reg memRead;

    dataMemory mem(.Clk(Clk),.address(address),.writeData(writeData),.memWrite(memWrite),.memRead(memRead));
    always #100 Clk=!Clk;

    initial begin

        Clk=0;
        address=0;
        writeData=0;
        memWrite=0;
        memRead=0;

        #185;
        memWrite=1'b1;
        address=32'b00000000000000000000000000000111;
        writeData=32'b11100000000000000000000000000000;

        #100;
        memWrite=1'b1;
        writeData=32'hffffffff;
        address=32'b00000000000000000000000000000110;

        #185;
        memRead=1'b1;
        memWrite=1'b0;
        address=32'b00000000000000000000000000000111;

        #80;
        memWrite=1;
        address=8;
        writeData=32'haaaaaaaa;

        #80;
        memWrite=0;
        memRead=1;
        address=6;


    end

endmodule
