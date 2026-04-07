`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Pulkit Raj
// Author2: Madhuvanth G.K
// Create Date: 25.01.2026 23:24:43
// Design Name: Processor Top
// Module Name: 
// Project Name: 32 bit Processor Design
// Target Devices
// Tool Versions: 
// Description: 
// 
// Dependencies: fetch_unit, operand_fetch, branch_unit, alu, memory unit, writeback, control unit
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - Modules instantiated
// Revision 0.03 - Modules input and outputs were optimized
// Revision 0.04 - Multi-cycle controller added
// Additional Comments: This processor will take custom instructions in instruction memory. For now its decided by 4bit switch to run different programs.
//////////////////////////////////////////////////////////////////////////////////
module processor_top(
    input [3:0]process_input,
    input clk,
    input rst_in,
    output reg [31:0]result_out
);
wire [12:0]control;
wire [31:0]branch;
wire isbranchTaken;
wire [31:0]PC;
wire [31:0]instruction;
wire [31:0]aluResult;
wire [31:0]ldResult;
wire [3:0]flags;
wire [3:0]rd_out;
wire [31:0]op1;
wire [31:0]op2;
wire [31:0]immx;
wire [3:0] rs1;
wire [3:0] rs2;
wire [31:0] wb_data;
wire [3:0] wb_addr;
wire iswriteback;
reg [1:0] state;
reg wb_en;
reg pc_en;
always@(posedge clk)
begin
if(rst_in)
begin
wb_en<=1'b0;
pc_en<=1'b0;
end
end
wire gated_iswrite;
assign gated_iswrite=iswriteback & wb_en;
regfile u0(
    .clk(clk),
    .rs_1_in(rs1),
    .rs_2_in(rs2),
    .write_address(wb_addr),
    .isw(gated_iswrite),
    .rstreg(rst_in),
    .data(wb_data),
    .op_1(op1),
    .op_2(op2)
);
fetch_unit u1(                         //Instruction memory is read, PC increments by 4 bytes, and a mux for branch signals
    .branchinfo_in(branch),      //Here we don't go in normal order, we follow jumps for constructs like if,for
    .isbranchTaken(isbranchTaken & pc_en),
    .operate(process_input),
    .clk_in(clk),
    .rst(rst_in),
    .pc_en(pc_en),
    .pc_out(PC),
    .inst_out(instruction)     //Instruction is read from memory and given to instruction buffer register
);
decode_unit u2(
    .instr_in(instruction),        //Instruction is input, get ra(15),rs1, rd(store the value), rs2 registers through mux in unit
    .control_in(control),
    .flags(flags),
    .PC(PC),
    .rd_out(rd_out),
    .rst(rst_in),
    .rs1_out(rs1),
    .rs2_out(rs2),           //Second operand
    .immx_out(immx),     //Takes 16 bit registers, like mov r1,15 here 15 is the immediate value
    .branchInfo(branch),//Signals that goes in branch unit as an input
    .isbranchTaken(isbranchTaken)
);
ALU_design u4(
    .op1_in(op1),                   //Operand 1 is taken for execution
    .op2_in(op2),                   //Operand 2 is taken in for execution
    .immx(immx),                 //Operand 2 can also be an immediate value or integer
    .control_in(control),
    .res_out(aluResult),      //The result of calculation is sent as a signal
    .flags(flags)          //ALU sends the values like zero, overflow, carry and all
);
memory_unit u5(
    .alu_resultin(aluResult),
    .op(op2),
    .control_in(control),
    .clk_in(clk),
    .Idresult(ldResult)
);
control_unit u7(
    .instr_in(instruction),
    .iswrite(iswriteback),
    .control_word(control)
);
writeback u6(
    .aluResult_in(aluResult),
    .ldResult_in(ldResult),
    .pc_in(PC),
    .control_in(control),
    .rd_in(rd_out),
    .wb_data(wb_data),
    .wb_addr(wb_addr)
);
always@(posedge clk)
begin
if(rst_in)
result_out<=32'b0;
else if(wb_en & iswriteback)
result_out<=wb_data;
end
endmodule
