`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/30 11:30:13
// Design Name: 
// Module Name: signext_tb
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


module signext_tb(

    );

    reg [15:0] inst;

    signext ext(.inst(inst));

    initial begin
        inst=16'b0000000000000000;

        #100;
        inst=16'b0000000000000001;

        #100;
        inst=16'b1111111111111111;

        #100;
        inst=16'b0000000000000010;

        #100;
        inst=16'b1111111111111110;
    end

endmodule
