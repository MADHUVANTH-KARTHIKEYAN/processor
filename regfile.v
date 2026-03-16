module regfile(
    //Read register
    input [3:0]rs_1_in,//Source register 1
    input [3:0]rs_2_in,//Source register 2
    input [3:0]write_address,
    input isw,
    input rstreg,
    input [31:0]data,
    output reg [31:0]op_1,
    output reg [31:0]op_2
);
assign w_en=0;
integer i;
reg[31:0] file[14:0];
always@(*)
if(~rstreg)
    if(w_en==0)
    begin
    op_1<=file[rs_1_in];
    op_2<=file[rs_2_in];
    end
    else
    file[write_address]=data;
else
    for(i=0; i<15;i=i+1)
    file[i]<=32'b0;
endmodule

