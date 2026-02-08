
//------------------------------------------------------------------------------
// File       : tb_and_gate.sv
// Author     : Punith R / 1BM24EC415
// Created    : 2026-02-08
// Module     : tb
// Project    : SystemVerilog and Verification (23EC6PE2SV)
// Faculty    : Prof. Ajaykumar Devarapalli
// Description: Testbench for 2-input AND gate with functional coverage and VCD.
//------------------------------------------------------------------------------

module tb;

    logic a, b, y;

    and_gate dut (.*);

    covergroup cg_and;
        cp_a : coverpoint a;
        cp_b : coverpoint b;
        cross_ab : cross cp_a, cp_b;
    endgroup

    cg_and cg = new();

    // --- VCD DUMPING ---
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        repeat (20) begin
            a = $urandom_range(0, 1);
            b = $urandom_range(0, 1);
            #5;
            cg.sample();
        end

        $display("Final Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule