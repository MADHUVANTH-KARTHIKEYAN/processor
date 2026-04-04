`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2026 14:49:15
// Design Name: 
// Module Name: imm_calc
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

module imm_calc(
    input [15:0]imm_in,
    input m1_in, m2_in,
    output reg [31:0]imm_out
);
always@(*)
begin
imm_out={16'b0,imm_in};
if(m1_in)
    imm_out={imm_in,16'b0};
else if(m2_in && imm_in[15])
    imm_out={16'hFFFF,imm_in};
end
endmodule
