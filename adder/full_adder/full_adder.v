// -----------------------------
// File Name: full_adder.v
// Creator  : lisy
// Function : full adder
// Update   :
// Copyright: lisy
// -----------------------------

module full_adder (
    // Module head (verilog-IEEE-2001 format)
    input  wire a_in,
    input  wire b_in,
    input  wire c_in,  // carry in
    output wire sum_out,
    output wire c_out  // carry out
);

    // Method 1: gate-level description
    assign sum_out = a_in ^ b_in ^ c_in;
    assign c_out = (a_in & b_in) | (b_in & c_in) | (c_in & a_in);

    // Method 2: RTL design for adder with the keyword "assign"
    // Behavior of this adder can be synthesizable
    // "assign" means connectivity, which is used to describe a combinational circuit
    // assign {c_out, sum_out} = a_in + b_in + c_in;

    // Method 3: RTL design for adder with the keyword "always"
    // always @(a_in, b_in, c_in)
    //     {c_out, sum_out} = a_in + b_in + c_in;
    
endmodule
