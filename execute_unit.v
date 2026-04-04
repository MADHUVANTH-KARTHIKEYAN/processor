`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Pulkit Raj 
// Author2: Madhuvanth G.K
// Create Date: 26.01.2026 09:59:26
// Design Name: 
// Module Name: operand_fetch
// Project Name: SimpleRisc Processor
// Target Devices: Arty Z7
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - Modules instantiated
// Additional Comments:ra what do we do and rd_out , why is it included with is St, and PC is added while calculating branch, if PC itself is 32 bits then what are we doing?
//////////////////////////////////////////////////////////////////////////////////

module execute_unit(
    input [31:0]instr_in, //get it       //Instruction is input, get ra(15),rs1, rd(store the value), rs2 registers through mux in unit
    input [12:0]control_in,
    input [3:0]flags,
    input [31:0]PC,
    input rst,          //Second operand
    output [3:0]rd_out,
    output [31:0]immx_out,     //Takes 16 bit registers, like mov r1,15 here 15 is the immediate value
    output [31:0] branchInfo,// isbranchtaken and branchpc
    output isbranchTaken,
    output [3:0] rs1_out,
    output [3:0] rs2_out
);
wire [31:0] branchTarget;
wire [3:0]rd;
wire [3:0]Address_1;
wire [3:0]Address_2;
wire m1,m2;
wire [15:0]imm;
wire [3:0]rs_1, rs_2;
wire [3:0]ra;
assign ra=4'b1111;
assign {rd,rs_1,rs_2}=instr_in[25:14];
assign {m1,m2,imm}=instr_in[17:0];
wire [26:0]offset;
assign offset=instr_in[26:0];
imm_calc sb1(
    .imm_in(imm),
    .m1_in(m1), //Upper byte assignment of imm
    .m2_in(m2), //Lower byte assignment of imm
    .imm_out(immx_out)
    );
branch_calc sb3(
    .pc_in(PC),
    .target_in(offset),
    .target_out(branchTarget)
);
mux_1 sb4(
    .in1(ra),
    .in2(rs_1),
    .sel(control_in[7]),//is Return
    .out(Address_1)
);
mux_1 sb5(
    .in1(rd),
    .in2(rs_2),
    .sel(control_in[5]),//is Store
    .out(Address_2)
);
wire or_ineq, or_ingt;
assign or_ineq=(flags[2])&(control_in[9]);//beq
assign or_ingt=(flags[3])&(control_in[10]);//bgt
assign isbranchTaken=(or_ineq)|(or_ingt)|(control_in[11]);//ubranch
mux_1#(.Width(32)) sb7
(
    .in1(branchTarget),
    .in2(PC),
    .sel(control_in[7]),
    .out(branchInfo)
);
assign rd_out=rd;
assign rs1_out = Address_1;
assign rs2_out = Address_2;
endmodule
