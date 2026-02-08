 //------------------------------------------------------------------------------
// File       : siso.sv
// Author     : Punith R / 1BM24EC415
// Created    : 2026-02-08
// Module     : siso
// Project    : SystemVerilog and Verification (23EC6PE2SV)
// Faculty    : Prof. Ajaykumar Devarapalli
// Description: 4-bit Serial-In Serial-Out (SISO) shift register.
//------------------------------------------------------------------------------


// --- DESIGN ---
module siso (
    input  logic clk,
    input  logic si,
    output logic so
);

    logic [3:0] q;

    assign so = q[3];

    always_ff @(posedge clk) begin
        q <= {q[2:0], si};
    end

endmodule
