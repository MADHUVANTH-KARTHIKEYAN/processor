module inst_decoder(
    input in,
    output imbit_out,
    output m1,
    output m2,
    output [3:0]rs_1_in,
    output [3:0]rs_2_in,
    output [3:0]rd,
    output imm_out,
    output reg offset
);
wire [4:0]opcode;
assign imbit=in[26];
assign opcode=in[31:27];
always(in)
    begin
        if(opcode[4]) //1 address instruction and zero address instruction
            if(~opcode[2])
            offset=in[27:0];
        else
            if(in[27])
            {rd,rs_1_in,m1,m2,imm_out}=in[26:0];
                if(opcode[3:0])
                
            else
            {rd,rs_1_in,rs_2_in}=in[26:15];
    end
endmodule
