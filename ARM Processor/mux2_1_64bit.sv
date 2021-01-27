`timescale 1ns/10ps

module mux2_1_64bit (sel, in, out);
	input logic sel;
	input logic [127:0] in;
	output logic [63:0] out;
	
	genvar i;
	generate
		for (i = 0; i < 64; i++) begin : eachMux
			mux2_1 m (.sel(sel), .in({in[i+64], in[i]}), .out(out[i]));
		end
	endgenerate
endmodule

module mux2_1_64bit_testbench();
	logic [127:0] in; 
	logic [63:0] out;
	logic sel;
	
	mux2_1_64bit dut (.sel, .in, .out);
	
	logic [63:0] a, b;
	
	assign a = 64'hfff;
	assign b = 64'hccc;
	
	initial begin 
		in = {a, b};
		sel = 0; #10;
		sel = 1;	#10;
	end
endmodule
