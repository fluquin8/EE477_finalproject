// control			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

`timescale 1ns/10ps

module alu (A, B, control, result, negative, zero, overflow, carry_out);
	input logic [63:0] A, B;
	input logic	[2:0]	control;
	output logic [63:0] result;
	output logic negative, zero, overflow, carry_out;
	parameter delay = 0.05;
	
	logic [64:0] carrier;
	assign carrier[0] = control[0];
	
	genvar i;
	generate 
		for (i = 0; i < 64; i++) begin : eachALU
			alu_slice as (.A(A[i]), .B(B[i]), .carry_in(carrier[i]), .carry_out(carrier[i + 1]), .control(control), .result(result[i]));
		end
	endgenerate
	
	assign carry_out = carrier[64];
	
	assign negative = result[63];
	
	xor #delay overflow_check (overflow, carrier[64], carrier[63]);
	
	zero_check zc(.zero, .alu_slice_results(result));
endmodule
