`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.02.2026 16:50:41
// Design Name: 
// Module Name: mux
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

module mux(
    input in1,
    input in2,
    input in3,
    input in4,
    input sel1,
    input sel2,
    output reg res_out
);
always@(*)
    begin
    res_out=1'b0;
    case({sel1,sel2})
    2'b00: res_out=in1;
    2'b01: res_out=in2;
    2'b10: res_out=in3;
    2'b11: res_out=in4;
    endcase
    end
endmodule
