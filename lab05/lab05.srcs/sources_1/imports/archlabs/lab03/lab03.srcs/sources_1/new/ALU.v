`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Shanghai Jiao Tong University
// Engineer: Zhicun Chen
// 
// Create Date: 2020/05/22 22:50:33
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] input1,
    input [31:0] input2,
    input [3:0] aluCtrOut,
    input [4:0] immediate,
    output reg zero,
    output reg [31:0] aluRes    
    );
    
    always @ (input1 or input2 or aluCtrOut)
    begin
        zero=0;
        case(aluCtrOut)
        4'b0000:
        begin
            aluRes=input1&input2;
            if(aluRes==0)
                zero=1;
            else
                zero=0;
        end
        4'b0001:
        begin
            aluRes=input1|input2;
            if(aluRes==0)
                zero=1;
            else
                zero=0;
        end
        4'b0010:
        begin
            aluRes=input1+input2;
            if(aluRes==0)
                zero=1;
            else
                zero=0;
        end
        4'b0110:
        begin
            aluRes=input1-input2;
            if(aluRes==0)
                zero=1;
            else
                zero=0;
        end
        4'b0111:
        begin
            if(input1<input2)
            begin
                aluRes=1;
                zero=0;
            end
            else
            begin
                aluRes=0;
                zero=1;
            end
        end
        4'b1000:
        begin
            aluRes=input2<<immediate;
            if(aluRes==0)
                zero=1;
            else
                zero=0;
        end
        4'b1001:
        begin
            aluRes=input2>>immediate;
            if(aluRes==0)
                zero=1;
            else
                zero=0;
        end
        4'b1100:
        begin
            aluRes=~(input1|input2);
            if(aluRes==0)
                zero=1;
            else
                zero=0;
        end
        default:
        begin
            aluRes=0;
            zero=1;
        end
        
        endcase
    end
    
endmodule
