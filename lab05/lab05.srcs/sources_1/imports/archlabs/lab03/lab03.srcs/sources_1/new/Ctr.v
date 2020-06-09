`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/22 15:15:59
// Design Name: 
// Module Name: Ctr
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


module Ctr(
    input [5:0] opCode,
    output reg regDst,
    output reg aluSrc,
    output reg memToReg,
    output reg regWrite,
    output reg memRead,
    output reg memWrite,
    output reg branch,
    output reg [2:0] aluOp,
    output reg jump,
    output reg jal
    );
    
    always @(opCode)
    begin
        case(opCode)
        6'b000000://R-type
        begin
            regDst=1;
            aluSrc=0;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b010;
            jump=0;
            jal=0;
        end
        6'b100011://I-type:lw
        begin
            regDst=0;
            aluSrc=1;
            memToReg=1;
            regWrite=1;
            memRead=1;
            memWrite=0;
            branch=0;
            aluOp=3'b000;
            jump=0;
            jal=0;
        end
        6'b101011://I-type:sw
        begin
            regDst=0;
            aluSrc=1;
            memToReg=0;
            regWrite=0;
            memRead=0;
            memWrite=1;
            branch=0;
            aluOp=3'b000; 
            jump=0;
            jal=0;           
        end
        6'b000100://I-type:beq
        begin
            regDst=0;
            aluSrc=0;
            memToReg=0;
            regWrite=0;
            memRead=0;
            memWrite=0;
            branch=1;
            aluOp=3'b001;
            jump=0;
            jal=0;
        end
        6'b000010://J-type:j
        begin
            regDst=0;
            aluSrc=0;
            memToReg=0;
            regWrite=0;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b000;
            jump=1;
            jal=0;
        end
        6'b001000://I-type:addi
        begin
            regDst=0;
            aluSrc=1;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b100;
            jump=0;
            jal=0;
        end
        6'b001100://I-type:andi
        begin
            regDst=0;
            aluSrc=1;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b111;
            jump=0;
            jal=0;
        end
        6'b001101://I-type:ori
        begin
            regDst=0;
            aluSrc=1;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b110;
            jump=0;
            jal=0;
        end
        6'b000011://J-type:jal
        begin
            regDst=0;
            aluSrc=0;
            memToReg=0;
            regWrite=1;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b000;
            jump=1;
            jal=1;
        end
        
        default:
        begin
            regDst=0;
            aluSrc=0;
            memToReg=0;
            regWrite=0;
            memRead=0;
            memWrite=0;
            branch=0;
            aluOp=3'b000;
            jump=0;
            jal=0;
        end
        endcase    
    end
endmodule
