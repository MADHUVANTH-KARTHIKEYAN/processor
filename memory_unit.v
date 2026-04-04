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
output reg [31:0]Idresult
);
reg[31:0] mem[1023:0];
always@(posedge clk_in)
begin
Idresult<=32'b0;
if(control_in[5])
mem[alu_resultin]<=op;
else if(control_in[6])
Idresult<=mem[alu_resultin];
end
endmodule
