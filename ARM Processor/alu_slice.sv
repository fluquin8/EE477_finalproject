// control			Operation						Notes:
// 000:			result = B						value of overflow and carry_out unimportant
// 010:			result = A + B
// 011:			result = A - B
// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant

`timescale 1ns/10ps
module alu_slice(A, B, carry_in, carry_out, control, result);
	input logic A, B, carry_in;
	input logic [2:0] control;
	output logic carry_out, result;
	parameter delay = 0.05;

	logic [7:0] into_mux;
	
	assign into_mux[0] = B;
	
	logic fulladder_result;
	logic not_B, chosen_B;
	not #delay n (not_B, B);
	mux2_1 m2 (.sel(control[0]), .in({not_B, B}), .out(chosen_B));
	fulladder adder (.A, .B(chosen_B), .carry_in, .carry_out, .sum(fulladder_result));
	assign into_mux[2] = fulladder_result;
	assign into_mux[3] = fulladder_result;
	
	and #delay a (into_mux[4], A, B);
	
	or #delay o (into_mux[5], A, B);
	
	xor #delay x (into_mux[6], A, B);
	
	mux8_1 m8 (.sel(control), .in(into_mux), .out(result));
endmodule

module alu_slice_testbench();
	logic A, B, carry_in;
	logic [2:0] control;
	logic carry_out, result;
	
	alu_slice dut (.A, .B, .carry_in, .carry_out, .control, .result);
	
	integer i;
	initial begin
		for (i = 0; i < 2**3; i++) begin
			{A, B, carry_in} = i;
			control = 3'b000; #10;
			control = 3'b010; #10;
			control = 3'b011; #10;
			control = 3'b100; #10;
			control = 3'b101; #10;
			control = 3'b110; #10;
		end
	end
endmodule
