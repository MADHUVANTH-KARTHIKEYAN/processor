`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2026 17:45:26
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input [31:0]address_in,
    input clk,
    input isbranchTaken,
    input rst,
    output reg [31:0]address_out

    );
reg [31:0]pc=32'b0;
always@(posedge clk)
begin
if(isbranchTaken)
pc<=address_in;
else if(rst)
pc<=31'b0;
else
pc <= pc+1'b1;
address_out<=pc;
end
endmodule

