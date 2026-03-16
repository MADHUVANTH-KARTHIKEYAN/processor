`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2026 17:24:04
// Design Name: 
// Module Name: branch_calc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:PC can't be combined with target, its an error.
// 
//////////////////////////////////////////////////////////////////////////////////


module branch_calc(
input [31:0] pc_in,
input [26:0]target_in,
output [31:0]target_out
);
reg [5:0]init;
always@(target_in) begin
if(target_in[26])
init=6'b111111;
else
init=6'b0;
end
wire [31:0] inter;
assign inter={init,target_in};
assign target_out=inter+pc_in;
endmodule

