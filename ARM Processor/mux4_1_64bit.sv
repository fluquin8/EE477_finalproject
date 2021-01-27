`timescale 1ns/10ps

module mux4_1_64bit (sel, in, out);
	input logic [1:0] sel;
	input logic [255:0] in;
	output logic [63:0] out;
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin : eachMux
			mux4_1 m (.sel(sel), .in({in[i+192], in[i+128], in[i+64], in[i]}), .out(out[i]));
		end
	endgenerate
endmodule

module mux4_1_64bit_testbench();
	logic [1:0] sel;
	logic [255:0] in;
	logic [63:0] out;

	mux4_1_64bit dut (.sel, .in, .out);
	
	logic [63:0] a, b, c, d;
	
	assign a = 64'haaa;
	assign b = 64'hbbb;
	assign c = 64'hccc;
	assign d = 64'hddd;
	
	initial begin
		in = {a, b, c, d};
		sel = 2'd0; #10;
		sel = 2'd1; #10;
		sel = 2'd2; #10;
		sel = 2'd3; #10;
	end
endmodule
