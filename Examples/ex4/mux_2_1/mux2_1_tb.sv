 
   // --- MUX 2:1 TESTBENCH ---
class Transaction;
    rand bit [7:0] a, b;
    rand bit       sel;
endclass


module tb;

    logic [7:0] a, b, y;
    logic       sel;

    mux2to1 dut (.*);

    covergroup cg_mux;
        cp_sel : coverpoint sel;   // We must see Sel=0 and Sel=1
    endgroup

    cg_mux      cg = new();
    Transaction tr = new();

    // --- VCD DUMPING ---
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
    end

    initial begin
        repeat (20) begin
            tr.randomize();              // Generate random values
            a   = tr.a;
            b   = tr.b;
            sel = tr.sel;

            #5;
            cg.sample();

            // Self-check
            if (y !== (sel ? b : a))
                $error("Mismatch!");
        end

        $display("Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
 
