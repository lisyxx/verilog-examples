// -----------------------------
// File Name: para_adder_tb.v
// Creator  : lisy
// Function : the testbench of full adder with parameters
// Update   :
// Copyright: lisy
// -----------------------------

module para_adder_tb;
    // Parameterization
    parameter WIDTH = 32;
    // Module head (verilog IEEE 1364-2001 format)
    reg  [WIDTH-1:0] ain;
    reg  [WIDTH-1:0] bin;
    reg              cin;
    wire [WIDTH-1:0] sumout;
    wire             cout;

    // Part 1: create an instance
    para_adder u0_para_adder(
        .a_in    (ain),
        .b_in    (bin),
        .c_in    (cin),
        .sum_out (sumout),
        .c_out   (cout)
    );

    // Part 2: generate clock and reset
    parameter CLK_PERIOD = 20;
    reg clk, reset_n;   // reset active low

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    initial begin
        reset_n = 0;
        #100
        reset_n = 1;
    end

    // Part 3: drive the stimulus and capture the response
    // Here is a testcase
    initial begin
        #110 ain = 32'b0; bin = 32'b0; cin = 0;
        #20  ain = 32'b1; bin = 32'b0; cin = 0;
        #20  ain = 32'b0; bin = 32'b1; cin = 0;
        #50  $finish;   // The tag to end driving
    end

    // Part 4: check the results
    always @(posedge clk) begin
        if (!reset_n) $display("%t:%m: reseting...", $time);  // Display reseting active
        else $display("%t:%m: reseting finished.", $time);    // Display reseting finished
    end
    
    initial begin
        #115 if ({cout, sumout} != 32'b0) $display("Error: {cout, sumout}=%b, ain=%b, bin=%b, cin=%b", {cout, sumout}, ain, bin, cin);
        #20  if ({cout, sumout} != 32'b1) $display("Error: {cout, sumout}=%b, ain=%b, bin=%b, cin=%b", {cout, sumout}, ain, bin, cin);
        #20  if ({cout, sumout} != 32'b1) $display("Error: {cout, sumout}=%b, ain=%b, bin=%b, cin=%b", {cout, sumout}, ain, bin, cin);
    end

    /* for VCS
    // Part 5: dump waveform with the compile option -debug all
    initial begin
        $vcdpluson;
    end
    */
    
endmodule // para_adder_tb
