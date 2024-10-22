`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Shanghai Jiao Tong University
// Engineer: Zhicun Chen
// 
// Create Date: 2020/05/22 09:46:27
// Design Name: 
// Module Name: adder_4bit_tb
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


module adder_4bit_tb(

    );
    
    reg [3:0] a;
    reg [3:0] b;
    reg ci;
    
    wire [3:0] s;
    wire co;
    
    adder_4bit u0(
        .a(a),
        .b(b),
        .ci(ci),
        .s(s),
        .co(co)
        );
        
    initial begin
        a=0;
        b=0;
        ci=0;
        
        #100;
        a=4'b0001;
        b=4'b0010;
        #100;
        a=4'b0010;
        b=4'b0100;
        
        #100;
        a=4'b1111;
        b=4'b0001;
        #100;
        ci=1'b1;
    end
endmodule
