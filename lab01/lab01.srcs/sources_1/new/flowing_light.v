`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Shanghai Jiao Tong University
// Engineer: Zhicun Chen
// 
// Create Date: 2020/05/22 08:10:15
// Design Name: 
// Module Name: flowing_light
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


module flowing_light(
    input clock,
    input reset,
    output [7:0] led
    );
    
    reg [23:0] cnt_reg;
    reg [7:0] light_reg;
    always @ (posedge clock)
        begin
            if(reset)
                cnt_reg<=0;
            else
                cnt_reg<=cnt_reg+1;
        end
    always @ (posedge clock)
            begin
                if(reset)
                    light_reg<=8'h01;
                else if(cnt_reg==24'h000001)
                    begin
                        if(light_reg==8'h80)
                            begin
                            light_reg<=8'h01;
                            cnt_reg<=0;
                            end
                        else
                            begin
                            light_reg<=light_reg<<1;
                            cnt_reg<=0;
                            end
                    end
                /* This is the original version code, modify beyond is aimed to decrease the change interval
                else if(cnt_reg==24'hffffff)
                    begin
                        if(light_reg==8'h80)
                            light_reg<=8'h01;
                        else
                            light_reg<=light_reg<<1;
                    end*/
            end
    assign led=light_reg;
endmodule
