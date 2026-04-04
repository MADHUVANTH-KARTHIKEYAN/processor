module arithmeticunit(
    input A_in,
    input B_in,
    input csel,
    input [3:0]s,
    input lsr,
    output c_out,
    output result
);
wire result1,result2;
mux h1(
    .in1(A_in),
    .in2(~A_in),
    .in3(lsr),
    .in4(1'b0),
    .sel1(s[3]),
    .sel2(s[2]),
    .res_out(result1)
);
mux h2(
    .in1((~B_in)|A_in),
    .in2(B_in),
    .in3(B_in),
    .in4(1'b0),
    .sel1(s[1]),
    .sel2(s[0]),
    .res_out(result2)
);
adder f1(result1,result2,csel,result,c_out);
endmodule
