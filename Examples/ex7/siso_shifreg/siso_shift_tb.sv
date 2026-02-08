 //------------------------------------------------------------------------------
// File       : tb_siso.sv
// Author     : Punith R / 1BM24EC415
// Created    : 2026-02-08
// Module     : tb
// Project    : SystemVerilog and Verification (23EC6PE2SV)
// Faculty    : Prof. Ajaykumar Devarapalli
// Description: Testbench for SISO shift register with functional coverage
//              and VCD dumping.
//------------------------------------------------------------------------------


// --- TESTBENCH ---
module tb;

    logic clk = 0;
    logic si;
    logic so;

    siso dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    logic [3:0] q_ref;

    // ---------------- COVERAGE ----------------
    covergroup cg_siso @(posedge clk);
        cp_si : coverpoint si;
        cp_so : coverpoint so;
    endgroup

    cg_siso cg = new();

    // ---------------- VCD ----------------
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        q_ref = 4'b0000;

        repeat (20) begin
            si = $urandom_range(0, 1);

            // Reference model
            q_ref = {q_ref[2:0], si};

            @(posedge clk);
        end

      
        $display(
            "Coverage = %0.2f %%",
            cg.get_inst_coverage()
        );

        $finish;
    end

endmodule