 //------------------------------------------------------------------------------
// File       : arbiter_tb.sv
// Author     : Punith R / 1BM24EC415
// Created    : 2026-02-08
// Description: Testbench for Arbiter with Assertion, Coverage & VCD
//------------------------------------------------------------------------------

`timescale 1ns/1ps

module arbiter_tb;

    logic        clk = 0;
    logic        rst;
    logic [3:0]  req;
    logic [3:0]  gnt;

    // Clock
    always #5 clk = ~clk;

    // DUT
    arbiter dut (
        .clk (clk),
        .rst (rst),
        .req (req),
        .gnt (gnt)
    );

    // ---------------- ASSERTION ----------------
    assert property (@(posedge clk) $onehot0(gnt))
        else $error("Protocol Violation: Multiple Grants!");

    // ---------------- COVERAGE ----------------
    covergroup cg_arb @(posedge clk);
        cp_req : coverpoint req {
            bins r0 = {4'b0001};
            bins r1 = {4'b0010};
            bins r2 = {4'b0100};
            bins r3 = {4'b1000};
        }

        cp_gnt : coverpoint gnt {
            bins g0 = {4'b0001};
            bins g1 = {4'b0010};
            bins g2 = {4'b0100};
            bins g3 = {4'b1000};
        }

        req_to_gnt : cross cp_req, cp_gnt;
    endgroup

    cg_arb cg = new();

    // ---------------- TEST ----------------
    initial begin
        $dumpfile("arbiter.vcd");
        $dumpvars(0, arbiter_tb);

        rst = 1;
        req = 0;
        @(posedge clk);
        rst = 0;

        repeat (30) begin
            req = $urandom_range(0, 15);
            @(posedge clk);
            cg.sample();
        end

        $display("Functional Coverage = %0.2f %%",
                 cg.get_inst_coverage());

        #10;
        $finish;
    end

endmodule