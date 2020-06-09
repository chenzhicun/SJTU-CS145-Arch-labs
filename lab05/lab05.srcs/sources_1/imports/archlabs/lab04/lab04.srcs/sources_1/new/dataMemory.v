`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/29 23:05:14
// Design Name: 
// Module Name: dataMemory
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


module dataMemory(
    input Clk,
    input [31:0] address,
    input [31:0] writeData,
    input memWrite,
    input memRead,
    output reg [31:0] readData
    );

    reg [31:0] memFile[0:63];
    
    initial begin
        $readmemh("D:/Project/archlabs/lab05/data.txt",memFile);
    end

    always @ (address)
    begin
        if (memRead && !memWrite)
            readData=memFile[address];
        // this else mainly for simulating readData at the beginning
        else
            readData=0;
    end

    always @ (negedge Clk)
    begin
        if(memWrite)
            memFile[address]=writeData;
    end

endmodule
