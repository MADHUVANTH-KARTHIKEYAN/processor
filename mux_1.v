`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2026 20:54:15
// Design Name: 
// Module Name: mux_1
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


module mux_1#(parameter Width=4)
(
    input [Width-1:0]in1,
    input [Width-1:0]in2,
    input sel,
    output reg [Width-1:0]out
    );
always@(*)
if(sel)
out=in1;
else
out=in2;
endmodule
