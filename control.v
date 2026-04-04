`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Author1: Pulkit Raj
// Author2: Madhuvanth G.K
// Create Date: 02.02.2026 22:48:38
// Design Name: 
// Module Name: control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Update1: Removed all the output and combined them as a single control word
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:Check for writeback do branch instruction have a writeback
// 
//////////////////////////////////////////////////////////////////////////////////

module control_unit(
    input [31:0]instr_in,
    output reg [12:0] control_word,
    output reg iswrite
);
always@(instr_in[31:27])
begin
    case(instr_in[31:27])
    5'b10010:begin control_word<={instr_in[26], 1'b1,12'b0}; iswrite<=1'b0; end//Ubranch
    5'b10001:begin control_word<={instr_in[26], 2'b01,5'b0, 6'b01011}; iswrite<=1'b0; end//bgt
    5'b10000:begin control_word<={instr_in[26], 3'b001,4'b0, 6'b01011}; iswrite<=1'b0; end//beq
    5'b10011:begin control_word<={instr_in[26], 4'b0001,8'b0}; iswrite<=1'b0; end
    5'b10100:begin control_word<={instr_in[26], 5'b00001,7'b0};iswrite<=1'b0; end//ret
    5'b01000:begin control_word<={instr_in[26], 6'b000001,6'b000110}; iswrite<=1'b1; end //ld, if ibit is 1 then it offsets the address
    5'b01010:begin control_word<={instr_in[26], 6'b0,1'b1,5'b00110}; iswrite<=1'b0; end//st
    5'b01001:begin control_word<={instr_in[26], 7'b0,5'b00010}; iswrite<=1'b0; end//cmp
    5'b00110:begin control_word<={instr_in[26], 7'b0,5'b11100}; iswrite<=1'b1; end//mov
    default:begin control_word<={instr_in[26], 7'b0,instr_in[31:27]}; iswrite<=1'b1; end//ALU calculations
    //Add-00010, Sub-01011, LSR-10110, LSL-11110, OR-00001, AND-00101, NOT-01110, MOV-00110 --- OPCODES
    //ALUsignal 5 bit, 4bit MSB describes operation, 1 bit represents carry select, and last bit lsb or control represents wb
    endcase // Control word={ibit, Ubranch, Bgt, Beq, Call, Ret, Ld, St, ALU Op, Writeback} 
end
endmodule
