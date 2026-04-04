`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Pulkit Raj
// Author2: Madhuvanth G.K
// Create Date: 25.01.2026 23:24:43
// Design Name: Processor fetch
// Module Name: fetch_unit
// Project Name: SimpleRisc Architecture
// Target Devices: Arty Z7, Arria, Basys 3
// Tool Versions: 
// Description: 
// 
// Dependencies: Instruction memory, Program counter, Adder, Mux
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - Modules instantiated
// Additional Comments:Fetch unit designed using top down approach
// 
//////////////////////////////////////////////////////////////////////////////////

module fetch_unit(
    input [31:0]branchinfo_in,     //Here we don't go in normal order, we follow jumps for constructs like if,for
    input isbranchTaken,
    input [3:0]operate,
    input clk_in,
    input rst,
    input pc_en,
    output [31:0]pc_out,
    output [31:0]inst_out
);
program_counter sb1(
    .address_in(branchinfo_in[31:0]),
    .clk(clk_in),
    .isbranchTaken(isbranchTaken),
    .rst(rst),
    .pc_en(pc_en),
    .address_out(pc_out)
);
wire [31:0] pc;
assign pc=pc_out;
instruction_memory sb2(
    .process_input_in(operate),
    .pc_in(pc),
    .clk(clk_in),
    .instruction_out(inst_out)
);
endmodule
