
//------------------------------------------------------------------------------
// File       : counter_4.sv
// Author     : Punith R / 1BM24EC415
// Created    : 2026-02-08
// Module     : counter
// Project    : SystemVerilog and Verification (23EC6PE2SV)
// Faculty    : Prof. Ajaykumar Devarapalli
// Description: 4-bit up counter with synchronous reset.
//------------------------------------------------------------------------------

module counter (
    input  logic       clk,
    input  logic       rst,
    output logic [3:0] count
);

    always_ff @(posedge clk) begin
        if (rst)
            count <= 4'b0000;
        else
            count <= count + 1'b1;
    end

endmodule











 
