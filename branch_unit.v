`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.01.2026 10:33:33
// Design Name: 
// Module Name: branch_unit
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


module branch_unit(
    input branchTarget_in, //its taken instead op1 so its assumed that its the branch address that's given to pc, if no return
    input op1_in,                    //its given to the mux, when there is return instruction
    input isret_in,                //Enables return or just a branch address
    input isbeq_in,               //If two numbers are equal we take a branch
    input isbgt_in,               //If one number is greater than the other number branch is taken
    input flag_E_in,              //cmp two numbers are equal sets E flag to 1
    input flag_GT_in,            //if first operand is greater than second than Gt, then its set to 1
    input isUBranch_in,          //Unconditional branch is taken
    output isbranchTaken_out,//Outputs if branch is required or not
    output branchPC_out            //This is the branch address
    );
wire or_ineq, or_ingt;
assign or_ineq=(flag_E_in)&(isbeq_in);
assign or_ingt=(flag_GT_in)&(isbgt_in);
assign isbranchTaken_out=(or_ineq)|(or_ingt)|(isUBranch_in);
mux sb3(
    .in1(branchTarget_in),
    .in2(op1_in),
    .sel(isret_in),
    .out(branchPC_out)
);
endmodule
