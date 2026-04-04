module regfile(
input clk,
input [3:0] rs_1_in,// source address1
input [3:0] rs_2_in,// source address2
input [3:0] write_address,
input isw,
input rstreg,
input [31:0] data,// data to write 
output reg [31:0] op_1,
output reg [31:0] op_2
);
reg [31:0] file[15:0];// 16-register of 32 bit size
genvar j;
generate
for(j=0;j<16;j=j+1) begin : RESET
always@(posedge clk)
begin
if(rstreg)
file[j]<=32'b0;
else if(isw && (write_address==j))
file[j]<=data;
end
end
endgenerate
always@(*)
begin
op_1=file[rs_1_in];
op_2=file[rs_2_in];
end
endmodule
