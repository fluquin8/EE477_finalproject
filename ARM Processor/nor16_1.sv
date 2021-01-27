`timescale 1ns/10ps

module nor16_1 (out, in);
	input logic [15:0] in;
	output logic out;
	parameter delay = 0.05;
	
	logic [3:0] temp;
	
	or #delay nor0 (temp[0], in[0], in[1], in[2], in[3]);
	or #delay nor1 (temp[1], in[4], in[5], in[6], in[7]);
	or #delay nor2 (temp[2], in[8], in[9], in[10], in[11]);
	or #delay nor3 (temp[3], in[12], in[13], in[14], in[15]);
	
	nor #delay o (out, temp[0], temp[1], temp[2], temp[3]);
endmodule

module nor16_1_testbench();
	logic [15:0] in;
	logic out;
	
	nor16_1 dut (.out, .in);
	
	integer i;
	initial begin
		for (i = 0; i < 2**16; i++) begin
			in = i; #10;
		end
	end
endmodule
