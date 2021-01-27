`timescale 1ns/10ps

module fulladder_64bit (sum, A, B);
	input logic [63:0] A, B;
	output logic [63:0] sum;
	
	logic [63:0] carrier;
	
	fulladder lsb (.A(A[0]), .B(B[0]), .carry_in(1'b0), .carry_out(carrier[0]), .sum(sum[0]));
	
	genvar i;
	generate
		for (i = 1; i < 64; i++) begin : adder
			fulladder otherbit (.A(A[i]), .B(B[i]), .carry_in(carrier[i-1]), .carry_out(carrier[i]), .sum(sum[i]));
		end
	endgenerate
endmodule

module fulladder_64bit_testbench();
	logic [63:0] A, B, sum;
	
	fulladder_64bit dut (.sum, .A, .B);
	
	initial begin
		A = 64'd100; B = 64'd2000; #10;
		A = 64'd5682; B = 64'd5000; #10;
	end
endmodule
