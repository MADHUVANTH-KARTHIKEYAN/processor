module writeback(
    input [31:0]aluResult_in,
    input [31:0]ldResult_in,
    input [31:0]pc_in,
    input [12:0]control_in,
    input [3:0]rd_in,
    input w_en,
    input rstwrite
);
wire [31:0]pc_inc;
wire w=1;
wire [31:0]result;
reg [3:0]address_signal;
wire [3:0]ra_in=1111;
assign pc_inc=pc_in+1'b1;
mux s1(
    .in1(aluResult_in),
    .in2(ldResult_in),
    .in3(pc_inc),
    .sel1(control_in[6]),
    .sel2(control_in[8]),
    .res_out(result)
);
always@(control_in[8],ra_in, rd_in)
if(control_in[8])
address_signal=ra_in;
else
address_signal=rd_in;
regfile po1(
    .isw(w_en),
    .data(result),
    .rstreg(rstwrite),
    .write_address(address_signal));
endmodule



