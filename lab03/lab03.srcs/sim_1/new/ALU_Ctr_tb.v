`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Shanghai Jiao Tong University
// Engineer: Zhicun Chen
// 
// Create Date: 2020/05/22 21:24:56
// Design Name: 
// Module Name: ALU_Ctr_tb
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


module ALU_Ctr_tb(

    );
    reg [1:0] aluOp;
    reg [5:0] funct;
    
    ALU_Ctr ctr(.funct(funct),.aluOp(aluOp));
    
    initial begin
    funct=0;
    aluOp=0;
    
    // Here is a problem that x1xxxxxx
    /*
    #100 aluOp=2'b00;funct=6'bxxxxxx;
    #100 aluOp=2'b01;funct=6'bxxxxxx;
    #100 aluOp=2'b1x;funct=6'bxx0000;
    #100 aluOp=2'b1x;funct=6'bxx0010;
    #100 aluOp=2'b1x;funct=6'bxx0100;
    #100 aluOp=2'b1x;funct=6'bxx0101;
    #100 aluOp=2'b1x;funct=6'bxx1010;
    #100 aluOp=2'b10;funct=6'b111111;
    */
    
    #100 aluOp=2'b00;funct=6'b000000;
    #100 aluOp=2'b01;funct=6'b000000;
    #100 aluOp=2'b10;funct=6'b000000;
    #100 aluOp=2'b10;funct=6'b000010;
    #100 aluOp=2'b10;funct=6'b000100;
    #100 aluOp=2'b10;funct=6'b000101;
    #100 aluOp=2'b10;funct=6'b001010;
    #100 aluOp=2'b10;funct=6'b111111;
    
    end
endmodule
