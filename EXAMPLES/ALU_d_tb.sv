//------------------------------------------------------------------------------
// File       : tb_alu.sv
// Author     : Punith R / 1BM24EC415
// Created    : 2026-02-08
// Module     : tb
// Project    : SystemVerilog and Verification (23EC6PE2SV)
// Faculty    : Prof. Ajaykumar Devarapalli
// Description: Testbench for ALU with enum-based functional coverage and VCD.
//------------------------------------------------------------------------------


// --- TESTBENCH ---
module tb;

    logic [7:0] a, b, y;
    opcode_e   op;

    alu dut (.*);

    covergroup cg_alu;
        cp_op : coverpoint op;
    endgroup

    cg_alu cg = new();

    // --- VCD DUMPING ---
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        repeat (50) begin
            a  = $urandom();
            b  = $urandom();
            op = opcode_e'($urandom_range(0, 3));
            #5;
            cg.sample();
        end

        $display("Coverage : %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule



 
