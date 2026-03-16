module ALU_design(
    input [31:0]op1_in,
    input [31:0]op2_in,
    input clk,
    input [31:0]immx,
    input [12:0]control_in,
    output reg [31:0]res_out,
    output reg [3:0]flags
);
wire [31:0]c;
wire [31:0]res;
reg[31:0]B;//Its the operand one, the one selected will be executed
always @(*)
begin
if(control_in[12])
B=immx;
else
B=op2_in;
end
wire [3:0]Sel;
wire sel1;
assign Sel=control_in[4:1];
assign sel1=control_in[0];
genvar i;
generate
    for(i=1; i<31; i=i+1)begin : Unit
        arithmeticunit u(op1_in[i], B[i],c[i-1], Sel, op1_in[i-1], op1_in[i+1], c[i], res[i]);
    end
endgenerate
arithmeticunit a1(op1_in[0], B[0],sel1, Sel, 0, op1_in[1], c[0], res[0]);
arithmeticunit a4(op1_in[31], B[31],c[30], Sel, op1_in[30], 0, c[31], res[31]);
always@(posedge clk)
res_out=res;
endmodule
