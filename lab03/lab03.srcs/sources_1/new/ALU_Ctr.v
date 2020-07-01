`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Shanghai Jiao Tong University
// Engineer: Zhicun Chen
// 
// Create Date: 2020/05/22 19:06:58
// Design Name: 
// Module Name: ALU_Ctr
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
// FIX:maybe the logic inside case statements has some problems, debug for the input x1xxxxxx.

module ALU_Ctr(
    input [5:0] funct,
    input [1:0] aluOp,
    output reg [3:0] aluCtrOut
    );
    always @(aluOp or funct)
    begin
        casex({aluOp,funct})
            8'b00xxxxxx: aluCtrOut=4'b0010;
            8'b1xxx0000: aluCtrOut=4'b0010;
            8'b1xxx0010: aluCtrOut=4'b0110;
            8'b1xxx0100: aluCtrOut=4'b0000;
            8'b1xxx0101: aluCtrOut=4'b0001;
            8'b1xxx1010: aluCtrOut=4'b0111;
            8'bx1xxxxxx: aluCtrOut=4'b0110;
            default: aluCtrOut=4'b1111;
        endcase
    end
endmodule
