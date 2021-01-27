`timescale 1ns/10ps

module decoder2_4(en, in, out);
	output logic [3:0] out;
	input logic [1:0] in; 
	input logic en;
	
	logic [1:0] wires;
	
	//built 2:4 decoder from 3 1:2 decoders
	//1 1:2 to take in MSB of input and enable
	//2 1:2 to take in LSB of input and outputs of other decoder to make last output
	
	decoder1_2 d0 (.en(en), .in(in[1]), .out(wires[1:0]));
	
	decoder1_2 d1 (.en(wires[0]), .in(in[0]), .out(out[1:0]));
	decoder1_2 d2 (.en(wires[1]), .in(in[0]), .out(out[3:2]));
endmodule

module decoder2_4_testbench();
	logic [3:0] out;
	logic [1:0] in;
	logic en;
	
	decoder2_4 dut(.en, .in, .out);
	
	integer i;
	initial begin
		for (i = 0; i < 2**3; i++) begin
			{en, in} = i; #10;
		end
	end
endmodule
	