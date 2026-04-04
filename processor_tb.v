`timescale 1ns / 1ps
module processor_tb;

// ── Inputs ──────────────────────────────────────────────
reg        clk;
reg        rst_in;
reg  [3:0] process_input;

// ── Outputs ─────────────────────────────────────────────
wire [31:0] result_out;

// ── DUT ─────────────────────────────────────────────────
processor_top dut (
    .process_input(process_input),
    .clk          (clk),
    .rst_in       (rst_in),
    .result_out   (result_out)
);

// ── Clock: 20 ns period ─────────────────────────────────
initial clk = 0;
always  #10 clk = ~clk;

// ── Per-cycle monitor ───────────────────────────────────
initial begin
    $display("  Time   |    PC    | Instruction |  aluResult | result_out | wb_addr | isWB");
    $monitor("%8t | %8h |  %8h   |  %8h  |  %8h  |   r%0d   |   %b",
             $time, dut.PC, dut.instruction,
             dut.aluResult, result_out,
             dut.wb_addr, dut.iswriteback);
end

// ── Stimulus ────────────────────────────────────────────
initial begin
    // assert reset for 2 cycles — forces PC = 0
    rst_in        = 1;
    process_input = 4'b0001;
    @(posedge clk); #1;
    @(posedge clk); #1;
    // release reset — PC steps 0 → 1 → 2
    rst_in = 0;
    repeat(20) @(posedge clk);

    $display("\n-------- Final Register File --------");
    $display("r3  = 0x%h  (expect 0x00000B4D = 2893)", dut.u0.file[3]);
    $display("r6  = 0x%h  (expect 0x00000551 = 1361)", dut.u0.file[6]);
    $display("r10 = 0x%h  (expect 0x0000109E = 4254)", dut.u0.file[10]);
    $display("result_out = 0x%h  (expect 0x0000109E)", result_out);
    $display("-------------------------------------");

    if (dut.u0.file[3]  === 32'h00000B4D &&
        dut.u0.file[6]  === 32'h00000551 &&
        dut.u0.file[10] === 32'h0000109E)
        $display("RESULT: PASS");
    else
        $display("RESULT: FAIL");

    $finish;
end

// ── Waveform dump ───────────────────────────────────────
initial begin
    $dumpfile("processor_tb.vcd");
    $dumpvars(0, processor_tb);
end

endmodule
