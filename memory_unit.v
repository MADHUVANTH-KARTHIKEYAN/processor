`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2026 15:50:13
// Design Name: 
// Module Name: memory_unit
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
module memory_unit(
input [31:0]alu_resultin,
input [31:0]op,
input [12:0]control_in,
input clk_in,
output reg Idresult
);
wire mdr,mar;
reg[31:0] mem[1023:0];
assign mar=alu_resultin;
assign mdr=op;
always@(posedge clk_in)
begin
if(control_in[5])
mem[alu_resultin]<=mdr;
else if(control_in[6])
Idresult<=mem[mar];
end
endmodule
