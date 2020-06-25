`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/02 17:04:15
// Design Name: 
// Module Name: instMemory
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


module instMemory(
    input [31:0] readAddress,
    output [31:0] inst
    );

    reg [7:0] memFile[0:127];

    initial begin
        $readmemb("instruction.txt",memFile);
    end

    assign inst={memFile[readAddress+3],memFile[readAddress+2],memFile[readAddress+1],memFile[readAddress]};

endmodule
