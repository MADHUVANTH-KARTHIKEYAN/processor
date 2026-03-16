`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Pulkit Raj
// Author2: Madhuvanth G.K
// Create Date: 25.01.2026 23:24:43
// Design Name: Processor fetch
// Module Name: 
// Project Name: SimpleRisc Architecture
// Target Devices: Arty Z7
// Tool Versions: 
// Description: 
// 
// Dependencies: fetch_unit, operand_fetch, branch_unit, alu, memory unit, writeback, control unit
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - Modules instantiated
// Revision 0.03 - Modules input and outputs were optimized
// Additional Comments: This processor will take custom instructions in instruction memory. For now its decided by 4bit switch to run different programs.
// Debug: Check for muxes, if any special muxes there.
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
fetch_unit u1(                         //Instruction memory is read, PC increments by 4 bytes, and a mux for branch signals
    .branchinfo_in(branch),      //Here we don't go in normal order, we follow jumps for constructs like if,for
    .isbranchTaken(isbranchTaken),
    .operate(process_input),
    .clk_in(clk),
    .rst(rst_in),
    .pc_out(PC),
    .inst_out(instruction)     //Instruction is read from memory and given to instruction buffer register
);

execute_unit u2(
    .instr_in(instruction),        //Instruction is input, get ra(15),rs1, rd(store the value), rs2 registers through mux in unit
    .control_in(control),
    .flags(flags),
    .PC(PC),
    .rd_out(rd_out),
    .rst(rst_in),
    .op1_out(op1),             //First operand 
    .op2_out(op2),            //Second operand
    .immx_out(immx),     //Takes 16 bit registers, like mov r1,15 here 15 is the immediate value
    .branchInfo(branch),//Signals that goes in branch unit as an input
    .isbranchTaken(isbranchTaken)
);
ALU_design u4(
    .op1_in(op1),                   //Operand 1 is taken for execution
    .clk(clk),
    .op2_in(op2),                   //Operand 2 is taken in for execution
    .immx(immx),                 //Operand 2 can also be an immediate value or integer(normally specified in little endian format in storage)
    .control_in(control),
    .res_out(aluResult),      //The result of calculation is sent as a signal
    .flags(flags)          //ALU sends the values like zero, overflow, carry and all, need to confirm on unit of flag
);

memory_unit u5(
    .alu_resultin(aluResult),
    .op(op2),
    .control_in(control),
    .clk_in(clk),
    .Idresult(ldResult)
);

wire iswriteback;
control_unit u7(
    .instr_in(instruction),
    .iswrite(iswriteback),
    .control_word(control)
);
writeback u6(
    .aluResult_in(aluResult),
    .ldResult_in(ldResult),
    .pc_in(PC),
    .rstwrite(rst_in),
    .control_in(control),
    .w_en(iswriteback),
    .rd_in(rd_out)                     //Store register value, we have to declare this assignments again in this file
);
endmodule