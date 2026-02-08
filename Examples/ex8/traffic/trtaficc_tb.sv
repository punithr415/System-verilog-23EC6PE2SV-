 //======================================================
// File Name   : traffic_tb.sv
// Description : Testbench with Coverage & VCD
//======================================================

`timescale 1ns/1ps

module traffic_tb;

    logic   clk = 0;
    logic   rst;
    light_t color;

    // Clock generation
    always #5 clk = ~clk;

    // DUT
    traffic dut (
        .clk   (clk),
        .rst   (rst),
        .color (color)
    );

    // ---------------- COVERAGE ----------------
    covergroup cg_light @(posedge clk);
        cp_color : coverpoint color {
            bins red    = {RED};
            bins green  = {GREEN};
            bins yellow = {YELLOW};

            // Full cycle coverage
            bins cycle = (RED => GREEN => YELLOW => RED);
        }
    endgroup

    cg_light cg = new();

    // ---------------- TEST SEQUENCE ----------------
    initial begin
        // VCD dump
        $dumpfile("traffic.vcd");
        $dumpvars(0, traffic_tb);

        // Reset
        rst = 1;
        @(posedge clk);
        rst = 0;

        // Run enough cycles to complete multiple loops
        repeat (10) @(posedge clk);

        // Coverage report
        $display("Traffic Light Coverage = %0.2f %%", cg.get_inst_coverage());

        #10;
        $finish;
    end

endmodule
