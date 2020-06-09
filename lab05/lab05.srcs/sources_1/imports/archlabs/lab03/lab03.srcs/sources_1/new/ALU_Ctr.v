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
    input [2:0] aluOp,
    output reg [3:0] aluCtrOut
    );
    always @(aluOp or funct)
    begin
        casex({aluOp,funct})
            9'b000xxxxxx: aluCtrOut=4'b0010;   // sw and lw
            9'b010100000: aluCtrOut=4'b0010;   // add 
            9'b010100010: aluCtrOut=4'b0110;   // sub
            9'b010100100: aluCtrOut=4'b0000;   // and
            9'b010100101: aluCtrOut=4'b0001;   // or
            9'b010101010: aluCtrOut=4'b0111;   // slt
            9'b010000000: aluCtrOut=4'b1000;   // sll
            9'b010000010: aluCtrOut=4'b1001;   // srl
            9'b001xxxxxx: aluCtrOut=4'b0110;   // beq
            9'b100xxxxxx: aluCtrOut=4'b0010;   // addi
            9'b111xxxxxx: aluCtrOut=4'b0000;   // andi
            9'b110xxxxxx: aluCtrOut=4'b0001;   // ori
            default: aluCtrOut=4'b1111;
        endcase
    end
endmodule
