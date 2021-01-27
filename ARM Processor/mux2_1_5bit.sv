`timescale 1ns/10ps

module mux2_1_5bit (sel, in, out);
	input logic sel;
	input logic [9:0] in;
	output logic [4:0] out;
	
	genvar i;
	generate
		for (i = 0; i < 5; i++) begin : eachMux
			mux2_1 m (.sel(sel), .in({in[i+5], in[i]}), .out(out[i]));
		end
	endgenerate
endmodule

module mux2_1_5bit_testbench();
	logic [9:0] in; 
	logic [4:0] out;
	logic sel;
	
	mux2_1_5bit dut (.sel, .in, .out);
	
	logic [4:0] a, b;
	
	assign a = 5'hf;
	assign b = 5'h0;
	
	initial begin 
		in = {a, b};
		sel = 0; #10;
		sel = 1;	#10;
	end
endmodule
