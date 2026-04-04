module writeback(
    input [31:0]aluResult_in,
    input [31:0]ldResult_in,
    input [31:0]pc_in,
    input [12:0]control_in,
    input [3:0]rd_in,
    output [31:0] wb_data,
    output [3:0] wb_addr
);
wire [31:0]pc_inc;
reg [3:0]address_signal;
wire [3:0]ra_in=4'b1111;
assign pc_inc=pc_in+1'b1;
assign wb_data = control_in[8] ? pc_inc :
                 control_in[6] ? ldResult_in :
                 aluResult_in;
always @(*) begin
if(control_in[8]) address_signal=ra_in;
else address_signal=rd_in;
end
assign wb_addr = address_signal;
endmodule
