// -----------------------------
// File Name: sequence.v
// Creator  : lisy
// Function : finite-state machine
// Update   :
// Copyright: lisy
// -----------------------------

// Sequence: 1110010 

module sequence
    // Parameterization
    #(parameter s0='d0, s1='d1, s2='d2, s3='d3, s4='d4, s5='d5, s6='d6, s7='d7)
(
    // Module head (verilog IEEE 1364-2001 format)
    input        in,
    input        clk,
    input        reset_n,
    output       out,
    output [2:0] state,
    reg [2:0] current_state,
    reg [2:0] next_state
);

    // first phase
    always @(posedge clk, negedge reeset_n) begin
        if (!reset_n) current_state <= s0;
        else current_state <= next_state;
    end

    // Transfer condition
    always @(in, current_state) begin
        case (current_state)
            s0: begin
                if (in == 0) next_state <= s0;
                else         next_state <= s1;
            end
            s1: begin
                if (in == 0) next_state <= s0;
                else         next_state <= s2;
            end
            s2: begin
                if (in == 0) next_state <= s0;
                else         next_state <= s3;
            end
            s3: begin
                if (in == 0) next_state <= 
