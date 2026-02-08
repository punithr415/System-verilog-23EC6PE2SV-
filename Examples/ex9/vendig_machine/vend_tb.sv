  //------------------------------------------------------------------------------
// File       : vending_tb.sv
// Author     : Punith R / 1BM24EC415
// Created    : 2026-02-08
// Module     : vending_tb
// Project    : SystemVerilog and Verification (23EC6PE2SV)
// Faculty    : Prof. Ajaykumar Devarapalli
// Description: Testbench for vending FSM with functional coverage
//              and VCD dumping (scope-safe).
//------------------------------------------------------------------------------

`timescale 1ns/1ps

module vending_tb;

    logic        clk = 0;
    logic        rst;
    logic [4:0]  coin;
    logic        dispense;

    // Clock
    always #5 clk = ~clk;

    // DUT
    vending dut (
        .clk      (clk),
        .rst      (rst),
        .coin     (coin),
        .dispense (dispense)
    );

    // ---------------- COVERAGE ----------------
    covergroup cg_vend @(posedge clk);
        cp_state : coverpoint dut.state {
            bins idle  = {2'b00}; // IDLE
            bins has5  = {2'b01}; // HAS5
            bins has10 = {2'b10}; // HAS10
        }
    endgroup

    cg_vend cg = new();

    // ---------------- TEST ----------------
    initial begin
        $dumpfile("vending.vcd");
        $dumpvars(0, vending_tb);

        // Reset
        rst = 1;
        coin = 0;
        @(posedge clk);
        rst = 0;

        // ---- DIRECTED TESTS (FOR 100% COVERAGE) ----
        coin = 5;   @(posedge clk); cg.sample(); // IDLE → HAS5
        coin = 10;  @(posedge clk); cg.sample(); // HAS5 → IDLE (dispense)

        coin = 10;  @(posedge clk); cg.sample(); // IDLE → HAS10
        coin = 5;   @(posedge clk); cg.sample(); // HAS10 → IDLE (dispense)

        // ---- RANDOM STIMULUS ----
        repeat (10) begin
            coin = ($urandom_range(0,1)) ? 5 : 10;
            @(posedge clk);
            cg.sample();
        end

        $display("Functional Coverage = %0.2f %%",
                 cg.get_inst_coverage());

        #10;
        $finish;
    end

endmodule
