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
    output reg [3:0] aluCtrOut,
    output reg jr
    );
    always @(aluOp or funct)
    begin
        casex({aluOp,funct})
            9'b000xxxxxx: // sw and lw
            begin 
                aluCtrOut=4'b0010;
                jr=0;
            end   
            9'b010100000: // add 
            begin
                aluCtrOut=4'b0010;
                jr=0;
            end
            9'b010100010: // sub
            begin
                aluCtrOut=4'b0110;
                jr=0;
            end
            9'b010100100: // and
            begin
                aluCtrOut=4'b0000;
                jr=0;
            end
            9'b010100101: // or
            begin
                aluCtrOut=4'b0001;
                jr=0;
            end
            9'b010101010: // slt
            begin
                aluCtrOut=4'b0111;
                jr=0;
            end
            9'b010000000: // sll
            begin
                aluCtrOut=4'b1000;
                jr=0;
            end
            9'b010000010: // srl
            begin
                aluCtrOut=4'b1001;
                jr=0;
            end
            9'b010001000: //jr
            begin
                aluCtrOut=4'b0010;
                jr=1;
            end
            9'b001xxxxxx: // beq
            begin
                aluCtrOut=4'b0110;
                jr=0;
            end
            9'b100xxxxxx: // addi
            begin
                aluCtrOut=4'b0010;
                jr=0;
            end
            9'b111xxxxxx: // andi
            begin
                aluCtrOut=4'b0000;
                jr=0;
            end
            9'b110xxxxxx: // ori
            begin
                aluCtrOut=4'b0001;
                jr=0;
            end
            default: 
            begin
                aluCtrOut=4'b1111;
                jr=0;
            end
        endcase
    end
endmodule
