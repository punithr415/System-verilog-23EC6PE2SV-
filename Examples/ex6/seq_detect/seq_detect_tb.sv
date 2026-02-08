  //======================================================
// File Name   : fsm101_tb.sv
// Description : Testbench for FSM 101 with Coverage & VCD
//======================================================

`timescale 1ns/1ps

module fsm101_tb;

    logic clk = 0;
    logic rst;
    logic in;
    logic out;

    // Clock generation
    always #5 clk = ~clk;

    // DUT
    fsm101 dut (
        .clk (clk),
        .rst (rst),
        .in  (in),
        .out (out)
    );

    // ---------------- COVERAGE (WHITE-BOX) ----------------
    covergroup cg_fsm @(posedge clk);
        cp_state : coverpoint dut.state {
            bins s0 = {0};
            bins s1 = {1};
            bins s2 = {2};
        }
    endgroup

    cg_fsm cg = new();

    // ---------------- TEST SEQUENCE ----------------
    initial begin
        // VCD dumping
        $dumpfile("fsm101.vcd");
        $dumpvars(0, fsm101_tb);

        // Reset
        rst = 1;
        in  = 0;
        @(posedge clk);
        rst = 0;

        // Apply stimulus (101101 pattern)
        repeat (10) begin
            @(posedge clk);
            in = $random % 2;
        end

        // Report coverage
        $display("FSM State Coverage = %0.2f %%", cg.get_inst_coverage());

        #10;
        $finish;
    end

endmodule
