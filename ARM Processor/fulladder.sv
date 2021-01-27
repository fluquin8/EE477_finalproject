`timescale 1ns/10ps

module fulladder(A, B, carry_in, carry_out, sum);
	input logic A, B, carry_in;
	output logic carry_out, sum;
	parameter delay = 0.05;

	logic xor_out, and_out0, and_out1;
	
	xor #delay xor0 (xor_out, A, B);
	xor #delay xor1 (sum, xor_out, carry_in);
	and #delay and0 (and_out0, xor_out, carry_in);
	and #delay and1 (and_out1, A, B);
	or #delay o (carry_out, and_out0, and_out1);
endmodule

module fulladder_testbench();
	logic A, B, carry_in, carry_out, sum;

	fulladder dut(.A, .B, .carry_in, .carry_out, .sum);
	
	integer i;
	initial begin
		for (i = 0; i < 2**3; i++) begin
			{A, B, carry_in} = i; #10;
		end
	end
endmodule
