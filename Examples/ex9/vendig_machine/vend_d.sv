  //------------------------------------------------------------------------------
// File       : vending.sv
// Author     : Punith R / 1BM24EC415
// Created    : 2026-02-08
// Module     : vending
// Project    : SystemVerilog and Verification (23EC6PE2SV)
// Faculty    : Prof. Ajaykumar Devarapalli
// Description: Simple vending machine FSM.
//              Accepts 5 or 10 value coins.
//              Dispenses item when total reaches 15.
//------------------------------------------------------------------------------

`timescale 1ns/1ps

module vending (
    input  logic        clk,
    input  logic        rst,
    input  logic [4:0]  coin,      // 5 or 10
    output logic        dispense
);

    typedef enum logic [1:0] {
        IDLE,
        HAS5,
        HAS10
    } state_t;

    state_t state, next;

    // State register
    always_ff @(posedge clk) begin
        if (rst)
            state <= IDLE;
        else
            state <= next;
    end

    // Next-state & output logic
    always_comb begin
        dispense = 0;
        next = state;

        case (state)
            IDLE: begin
                if (coin == 5)  next = HAS5;
                if (coin == 10) next = HAS10;
            end

            HAS5: begin
                if (coin == 10) begin
                    dispense = 1;
                    next = IDLE;
                end
            end

            HAS10: begin
                if (coin == 5) begin
                    dispense = 1;
                    next = IDLE;
                end
            end
        endcase
    end

endmodule
