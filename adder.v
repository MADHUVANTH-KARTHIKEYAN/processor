`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2026 16:58:20
// Design Name: 
// Module Name: adder
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
module adder(
    input X_in,
    input Y_in,
    input c_in,
    output result_out,
    output carry);
assign result_out= (X_in^Y_in)^c_in;
assign carry= (X_in&Y_in)|(Y_in&c_in)|(X_in&c_in);
endmodule
