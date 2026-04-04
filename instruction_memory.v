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
reg [31:0]addin;
always@(posedge clk)
begin
addin<=pc_in;
end

always@(addin, process_input_in)
begin
instruction_out=32'b0;
if(process_input_in==4'b0001)
begin
case(addin)
0: instruction_out= 32'b00110_1_0011_1010_00_0000101101001101;
1: instruction_out= 32'b00110_1_0110_1011_00_0000010101010001;
2: instruction_out= 32'b00010_0_1010_0011_0110_00000000000000;
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
