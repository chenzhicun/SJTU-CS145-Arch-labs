`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 11:33:53
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

    reg Clk,reset;
    always #50 Clk = !Clk;

    Top top(.Clk(Clk),.reset(reset));

    initial begin
        Clk=0;
        reset=1;
        #100
        //$readmemb("instruction.txt",top.instMem.memFile);
        //$readmemh("data.txt",top.dataMem.memFile);
        reset=0;
        #1900;
        reset=1;
        #100;
    end
endmodule
