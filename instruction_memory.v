`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2026 16:11:54
// Design Name: 
// Module Name: instruction_memory
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

module instruction_memory(
    input  [3:0] process_input_in,
    input [31:0] pc_in,
    input clk,
    output reg [31:0] instruction_out
);

wire [31:0] addin;
assign addin = pc_in;

always@(*)
begin
instruction_out=32'b0;
if(process_input_in==4'b0001)
begin
case(addin)
0: instruction_out= 32'b10110_1_0011_0000_00_0000000000000110; 


default: instruction_out= 32'b0;
endcase
end
else if(process_input_in==4'b0010)
begin
case(addin)
0: instruction_out= 10001;
default: instruction_out= 32'b0;
endcase
end
else if(process_input_in==4'b0011)
begin
case(addin)
0: instruction_out= 10001;
default: instruction_out= 32'b0;
endcase
end
end
endmodule
