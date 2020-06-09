`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
            8'b00xxxxxx: aluCtrOut=4'b0010;   // sw and lw
            8'b10100000: aluCtrOut=4'b0010;   // add 
            8'b10100010: aluCtrOut=4'b0110;   // sub
            8'b10100100: aluCtrOut=4'b0000;   // and
            8'b10100101: aluCtrOut=4'b0001;   // or
            8'b10101010: aluCtrOut=4'b0111;   // slt
            8'b10000000: aluCtrOut=4'b1000;   // sll
            8'b10000010: aluCtrOut=4'b1001;   // srl
            8'bx1xxxxxx: aluCtrOut=4'b0110;   // beq
            default: aluCtrOut=4'b1111;
        endcase
    end
endmodule
