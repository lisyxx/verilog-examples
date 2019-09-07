// -----------------------------
// File Name: full_adder_tb.v
// Creator  : lisy
// Function : the testbench of full adder
// Update   :
// Copyright: lisy
// -----------------------------

module full_adder_tb;
    
    reg ain, bin, cin;   // Drive the input ports with the reg type
    wire sumout, cout;   // Sample the output ports with the wire type

    // Part 1: create an instance
    // Behavior of the adder can be synthesizable
    // assign {c_out, sum_out} = a_in + b_in + c_in;
    full_adder u0_full_adder(
        // Module head: verilog-IEEE-2001 format
        .a_in    (ain),     // input wire
        .b_in    (bin),     // input wire
        .c_in    (cin),     // input wire, carry in
        .sum_out (sumout),  // output wire
        .c_out   (cout)     // output wire, carry out
    );

    // Part 2: generate clock and reset
    parameter CLK_PERIOD = 20;
    reg clk, reset_n;   // reset_n : reset active low

    initial begin
        clk = 0;
        forever
            #(CLK_PERIOD/2) clk = ~clk;
    end

    initial begin
        reset_n = 0;
        #100   // delay 100 ns (time-unit is defined by timescale)
        reset_n = 1;
    end

    // Part 3: drive the stimulus and capture the response
    // Here is a testcase
    initial begin
        #110 ain = 0;
             bin = 0;
             cin = 0;   // 00
        #20  ain = 0;
             bin = 1;
             cin = 0;   // 01
        #20  ain = 1;
             bin = 0;
             cin = 0;   // 01
        #20  ain = 1;
             bin = 1;
             cin = 0;   // 10
        #20  ain = 0;
             bin = 0;
             cin = 1;   // 01
        #20  ain = 0;
             bin = 1;
             cin = 1;   // 10
        #20  ain = 1;
             bin = 0;
             cin = 1;   // 10
        #20  ain = 1;
             bin = 1;
             cin = 1;   // 11
		#50  $finish;   // A system task which can stop the simulation
	end

    // Part 4: check the results
    // Check the reset and clock
	always @(posedge clk) begin
		if (!reset_n) begin
			$display("%t:%m: resetting ...", $time);   //count 5 clocks
		end
		else begin
			$display("%t:%m: resetting finish", $time);   //start from 6th clock
		end
	end

    // Check every stimulus and display error
	initial begin
		#115 if ({cout,sumout} != 2'b00) $display("Error: {cout,sumout}=%b, ain=%b, bin=%b, cin=%b", {cout,sumout}, ain, bin, cin);
		#20  if ({cout,sumout} != 2'b01) $display("Error: {cout,sumout}=%b, ain=%b, bin=%b, cin=%b", {cout,sumout}, ain, bin, cin);
		#20  if ({cout,sumout} != 2'b01) $display("Error: {cout,sumout}=%b, ain=%b, bin=%b, cin=%b", {cout,sumout}, ain, bin, cin);
		#20  if ({cout,sumout} != 2'b10) $display("Error: {cout,sumout}=%b, ain=%b, bin=%b, cin=%b", {cout,sumout}, ain, bin, cin);
		#20  if ({cout,sumout} != 2'b01) $display("Error: {cout,sumout}=%b, ain=%b, bin=%b, cin=%b", {cout,sumout}, ain, bin, cin);
		#20  if ({cout,sumout} != 2'b10) $display("Error: {cout,sumout}=%b, ain=%b, bin=%b, cin=%b", {cout,sumout}, ain, bin, cin);
		#20  if ({cout,sumout} != 2'b10) $display("Error: {cout,sumout}=%b, ain=%b, bin=%b, cin=%b", {cout,sumout}, ain, bin, cin);
		#20  if ({cout,sumout} != 2'b11) $display("Error: {cout,sumout}=%b, ain=%b, bin=%b, cin=%b", {cout,sumout}, ain, bin, cin);
	end

    /* Code for VCS
    // Part 5: dump waveform with the compile option -debug_all
	initial begin
	    $vcdpluson;
	end
    */

endmodule
