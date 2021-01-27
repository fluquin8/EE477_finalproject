`timescale 1ns/10ps

module decoder1_2(en, in, out);
	output logic [1:0] out;
	input logic in, en;
	parameter delay = 0.05;
	
	//implement basic decoder logic
	// out0 = ~in & en
	// out1 = in & en
	
	logic not_in;
	not #delay n (not_in, in);
	and #delay out0 (out[0], not_in, en);
	
	and #delay out1 (out[1], in, en);
endmodule

module decoder1_2_testbench();
	logic en, in;
	logic [1:0] out;
	
	decoder1_2 dut(.en, .in, .out);
		
	integer i;
	initial begin
		for (i = 0; i < 2**2; i++) begin
			{en, in} = i; #10;
		end
	end
endmodule
