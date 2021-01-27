`timescale 1ns/10ps

module mux2_1(sel, in, out);
	output logic out;
	input logic sel;
	input logic [1:0] in;
	parameter delay = 0.05; //0.05 ns is 50 ps
	
	//implement basic logic for mux
	// out = (in0 & ~sel) | (in1 & sel)
	logic not_sel;
	not #delay n (not_sel, sel);
	
	logic [1:0] and_result;
	and #delay a0 (and_result[0], not_sel, in[0]);
	and #delay a1 (and_result[1], sel, in[1]);
	
	or #delay o (out, and_result[0], and_result[1]);
	
endmodule

module mux2_1_testbench();
	logic out, sel;
	logic [1:0] in;
	
	mux2_1 dut (.sel, .in, .out);   
	
	integer i;
	initial begin
		for (i = 0; i < 2**3; i++) begin
			{sel, in} = i; #10;
		end
	end
endmodule
