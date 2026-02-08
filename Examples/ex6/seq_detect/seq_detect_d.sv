 //======================================================
// File Name   : fsm101_design.sv
// Module Name : fsm101
// Description : Sequence Detector for "101" (Overlapping)
// Author      : Punith R
//======================================================

module fsm101 (
    input  logic clk,
    input  logic rst,
    input  logic in,
    output logic out
);

    typedef enum logic [1:0] {S0, S1, S2} state_t;
    state_t state, next;

    // State register
    always_ff @(posedge clk) begin
        if (rst)
            state <= S0;
        else
            state <= next;
    end

    // Next-state & output logic
    always_comb begin
        next = state;
        out  = 0;

        case (state)
            S0: begin
                if (in) next = S1;
            end

            S1: begin
                if (!in) next = S2;
                else     next = S1;
            end

            S2: begin
                if (in) begin
                    next = S1;
                    out  = 1;   // "101" detected
                end
                else
                    next = S0;
            end
        endcase
    end

endmodule
