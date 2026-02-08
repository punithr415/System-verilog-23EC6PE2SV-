 //======================================================
// File Name   : traffic_design.sv
// Module Name : traffic
// Description : Traffic Light Controller (RED→GREEN→YELLOW)
//======================================================

typedef enum logic [1:0] {RED, GREEN, YELLOW} light_t;

module traffic (
    input  logic   clk,
    input  logic   rst,
    output light_t color
);

    always_ff @(posedge clk) begin
        if (rst)
            color <= RED;
        else begin
            case (color)
                RED:    color <= GREEN;
                GREEN:  color <= YELLOW;
                YELLOW: color <= RED;
                default:color <= RED;
            endcase
        end
    end

endmodule
