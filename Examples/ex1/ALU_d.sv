 //------------------------------------------------------------------------------
// File       : alu.sv
// Author     : Punith R / 1BM24EC415
// Created    : 2026-02-08
// Module     : alu
// Project    : SystemVerilog and Verification (23EC6PE2SV)
// Faculty    : Prof. Ajaykumar Devarapalli
// Description: 8-bit ALU supporting ADD, SUB, AND, OR operations using enum.
//------------------------------------------------------------------------------

typedef enum bit [1:0] {ADD, SUB, AND, OR} opcode_e;


// --- ALU DESIGN ---
module alu (
    input  logic [7:0] a,
    input  logic [7:0] b,
    input  opcode_e    op,
    output logic [7:0] y
);

    always_comb begin
        case (op)
            ADD: y = a + b;
            SUB: y = a - b;
            AND: y = a & b;
            OR : y = a | b;
        endcase
    end

endmodule




 
