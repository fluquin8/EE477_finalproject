`timescale 1ns/10ps

module mov_shifter (out, imm, replacee, shift);
	input logic [15:0] imm;
	input logic [63:0] replacee;
	input logic [1:0] shift;
	output logic [63:0] out;
	
	logic [63:0] out0, out1, out2, out3;
	
	assign out0 = {replacee[63:16], imm};
	assign out1 = {replacee[63:32], imm, replacee[15:0]};
	assign out2 = {replacee[63:48], imm, replacee[31:0]};
	assign out3 = {imm, replacee[47:0]};
	
	mux4_1_64bit shiftselect (.sel(shift), .in({out3, out2, out1, out0}), .out(out));
endmodule

module mov_shifter_testbench();
	logic [15:0] imm;
	logic [63:0] replacee;
	logic [1:0] shift;
	logic [63:0] out;
	
	mov_shifter dut (.out, .imm, .replacee, .shift);
	
	logic [63:0] rd0, rdk;
	logic [15:0] immediate;
	
	assign rd0 = 64'd0;
	assign rdk = 64'haaaaaaaaaaaaaaaa;
	assign immediate = 16'hffff;
	
	initial begin
		imm = immediate;
		replacee = rd0;
		shift = 2'b00; #10;
		shift = 2'b01; #10;
		shift = 2'b10; #10;
		shift = 2'b11; #10;
		replacee = rdk;
		shift = 2'b00; #10;
		shift = 2'b01; #10;
		shift = 2'b10; #10;
		shift = 2'b11; #10;
	end
endmodule
