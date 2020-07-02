`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Shanghai Jiao Tong University
// Engineer: Zhicun Chen
// 
// Create Date: 2020/06/25 17:20:43
// Design Name: 
// Module Name: Top_tb
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


module Top_tb(

    );

    reg Clk, reset;
    always #50 Clk = !Clk;

    Top top(.Clk(Clk),.reset(reset));

    initial begin
        Clk = 0;
        reset = 1;
        #100
        reset = 0;
        #3000
        reset = 1;
    end
endmodule
