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
reg [31:0]interim;
reg [31:0]addin;
always@(posedge clk)
begin
addin<=pc_in;
end

always@(addin, process_input_in)
begin
if(process_input_in==4'b0001)
begin
case(addin)
4'b0000: interim= 32'b00110_1_0011_1010_0000101101001101;
4'b0001: interim= 32'b00110_1_0110_1011_0000010101010001;
4'b0010: interim= 32'b00010_0_1010_0011_0110_1001_1111_1101_01;
endcase
end
else if(process_input_in==4'b0010)
begin
case(addin)
4'b0000: interim= 10001;
endcase
end
else if(process_input_in==4'b0011)
begin
case(addin)
4'b0000: interim= 10001;
endcase
end
instruction_out=interim;
end
endmodule