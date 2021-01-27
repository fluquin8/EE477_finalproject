`timescale 1ns/10ps

module pc (out, in, clk, reset);
	input logic clk, reset;
	input logic [63:0] in;
	output logic [63:0] out;
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin : eachdff
			D_FF ff (.q(out[i]), .d(in[i]), .reset(reset), .clk(clk));
		end
	endgenerate
endmodule
