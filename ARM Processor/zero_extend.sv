`timescale 1ns/10ps

module zero_extend #(parameter width = 8) (out, in);
	input logic [width-1:0] in;
	output logic [63:0] out;
	
	assign out = {{(64-width){1'b0}}, in[width-1:0]};
endmodule

module zero_extend_testbench();
	logic [7:0] in;
	logic [63:0] out;

	zero_extend dut (.out, .in);
	
	initial begin
		in = 8'b11111011; #10;
		in = 8'b00000101; #10;
	end
endmodule
