
//------------------------------------------------------------------------------
// File       : tb_dff.sv
// Author     : Punith R / 1BM24EC415
// Created    : 2026-02-08
// Module     : tb
// Project    : SystemVerilog and Verification (23EC6PE2SV)
// Faculty    : Prof. Ajaykumar Devarapalli
// Description: Testbench for D Flip-Flop using constrained random stimulus,
//              cross coverage, and VCD dumping.
//------------------------------------------------------------------------------


class packet;
    rand bit d, rst;

    // Weight distribution: rst = 0 (90%), rst = 1 (10%)
    constraint c1 { rst dist {0 := 90, 1 := 10}; }
endclass


module tb;

    logic clk = 0;
    logic rst, d, q;

    dff dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    // Coverage: sample on rising edge of clock
    covergroup cg @(posedge clk);
        cross_rst_d : cross rst, d;
    endgroup

    cg     cg_inst = new();
    packet pkt     = new();

    // --- VCD DUMPING ---
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        repeat (100) begin
            pkt.randomize();
            rst <= pkt.rst;
            d   <= pkt.d;
            @(posedge clk);
        end

        $display("Coverage : %0.2f %%", cg_inst.get_inst_coverage());
        $finish;
    end

endmodule







 
