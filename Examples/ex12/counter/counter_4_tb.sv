
 //------------------------------------------------------------------------------
// File       : tb_counter.sv
// Author     : Punith R / 1BM24EC415
// Created    : 2026-02-08
// Module     : tb
// Project    : SystemVerilog and Verification (23EC6PE2SV)
// Faculty    : Prof. Ajaykumar Devarapalli
// Description: Testbench for 4-bit counter with rollover functional coverage
//              and VCD dumping.
//------------------------------------------------------------------------------


// --- TESTBENCH ---
module tb;

    logic       clk = 0;
    logic       rst;
    logic [3:0] count;

    counter dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    // Coverage: check zero, max, and rollover
    covergroup cg_count @(posedge clk);
        cp_val : coverpoint count {
            bins zero = {0};
            bins max  = {15};
            bins roll = (15 => 0);   // Crucial rollover check
        }
    endgroup

    cg_count cg = new();

    // --- VCD DUMPING ---
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        rst = 1;
        #20;
        rst = 0;

        repeat (40) @(posedge clk);   // Run enough cycles to wrap

        $display(
            "Rollover Hit? %0d",
            cg.cp_val.roll.get_coverage()
        );

        $finish;
    end

endmodule








 
