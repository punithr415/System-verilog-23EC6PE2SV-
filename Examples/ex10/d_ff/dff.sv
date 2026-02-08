
//------------------------------------------------------------------------------
// File       : dff.sv
// Author     : Punith R / 1BM24EC415
// Created    : 2026-02-08
// Module     : dff
// Project    : SystemVerilog and Verification (23EC6PE2SV)
// Faculty    : Prof. Ajaykumar Devarapalli
// Description: D Flip-Flop with asynchronous reset.
//------------------------------------------------------------------------------

module dff (
    input  logic clk,
    input  logic rst,
    input  logic d,
    output logic q
);

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule










 
