`timescale 1ns/10ps

module zero_check (zero, alu_slice_results);
	input logic [63:0] alu_slice_results;
	output logic zero;
	parameter delay = 0.05;
	
	logic [3:0] temp;
	
	nor16_1 n0 (temp[0], alu_slice_results[15:0]);
	nor16_1 n1 (temp[1], alu_slice_results[31:16]);
	nor16_1 n2 (temp[2], alu_slice_results[47:32]);
	nor16_1 n3 (temp[3], alu_slice_results[63:48]);
	
	and #delay n (zero, temp[0], temp[1], temp[2], temp[3]);
endmodule

module zero_check_testbench();
	logic [63:0] alu_slice_results;
	logic zero;
	
	zero_check dut (.zero, .alu_slice_results);

	initial begin
		alu_slice_results = 64'h0; #10;
		alu_slice_results = 64'h27c; #10;
		alu_slice_results = 64'h1; #10;
	end
endmodule
