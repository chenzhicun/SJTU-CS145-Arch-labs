`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/22 23:20:17
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb(

    );
    reg [31:0] input1;
    reg [31:0] input2;
    reg [3:0] aluCtrOut;
    
    ALU alu(
        .input1(input1),
        .input2(input2),
        .aluCtrOut(aluCtrOut)
    );
    
    initial begin
        input1=0;
        input2=0;
        aluCtrOut=4'b0000;
        
        #100;
        input1=15;
        input2=10;
        aluCtrOut=4'b0000;
        
        #100 aluCtrOut=4'b0001;
        #100 aluCtrOut=4'b0010;
        #100 aluCtrOut=4'b0110;
        #100;
        input1=10;
        input2=15;
        #100;
        aluCtrOut=4'b0111;
        input1=15;
        input2=10;
        #100;
        input1=10;
        input2=15;
        #100;
        aluCtrOut=4'b1100;
        input1=1;
        input2=1;
        #100 input1=16;
        
        
        
    end
    
    
endmodule
