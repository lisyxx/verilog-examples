// -----------------------------
// File Name: para_adder.v
// Creator  : lisy
// Function : full adder with parameters which define the WIDTH
// Update   :
// Copyright: lisy
// -----------------------------

module para_adder
    // parameterization design
    #(parameter WIDTH = 32)
(
    // module head (verilog-IEEE-2001 format)
    input  wire [WIDTH-1:0] a_in,
    input  wire [WIDTH-1:0] b_in,
    input  wire             c_in,    // carry in
    output wire [WIDTH-1:0] sum_out,
    output wire             c_out     // carry out
);

    // behavior of the adder can be synthesizable
    // "assing" means connectivity
    assign {c_out, sum_out} = a_in + b_in + c_in;
    
endmodule
