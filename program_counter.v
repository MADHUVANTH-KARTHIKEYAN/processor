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
    input pc_en,
    output reg [31:0]address_out

    );
reg [31:0]pc=32'b0;
always@(posedge clk)
begin
if(rst)
pc<=32'b0;
else if(isbranchTaken)
pc<=address_in;
else if(pc_en)
pc <= pc+1'b1;
address_out<=pc;
end
endmodule
