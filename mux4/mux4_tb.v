// -----------------------------
// File Name: mux4_tb.v
// Creator  : lisy
// Function : the testbench of 4 to 1 mux
// Update   :
// Copyright: lisy
// -----------------------------

module mux4_tb;
    
    reg c0, d0, e0, f0;
    reg [1:0] select0;
    wire muxout;   // Sample the output ports with the wire type

    // Part 1: create an instance
    mux4 u0_mux4(
        // Module head: verilog-IEEE-2001 format
        .c       (c0),
        .d       (d0),
        .e       (e0),
        .f       (f0),
        .select  (select0),
        .mux_out (muxout)
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
        #110 c0 = 1; d0 = 0; e0 = 0; f0 = 0; select0 = 2'b00;
        #20  c0 = 0; d0 = 1; e0 = 0; f0 = 0; select0 = 2'b01;
        #20  c0 = 0; d0 = 0; e0 = 1; f0 = 0; select0 = 2'b11;
        #20  c0 = 0; d0 = 0; e0 = 0; f0 = 1; select0 = 2'b10;
        #50  $finish;   // A system task which can end the simulation
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
	integer i;
	initial begin
        #115 if (muxout != 1) $display("Error: muxout=%b, c0=%b, d0=%b, e0=%b, f0=%b, select0=%b", muxout, c0, d0, e0, f0, select0);
        i = 1;
        while (i<4) begin
            #20 if (muxout != 1) $display("Error: muxout=%b, c0=%b, d0=%b, e0=%b, f0=%b, select0=%b", muxout, c0, d0, e0, f0, select0);
            i = i + 1;
        end
	end

    /* Code for VCS
    // Part 5: dump waveform with the compile option -debug_all
	initial begin
	    $vcdpluson;
	end
    */

endmodule
