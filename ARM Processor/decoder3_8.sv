`timescale 1ns/10ps

module decoder3_8(en, in, out);
	output logic [7:0] out;
	input logic [2:0] in; 
	input logic en;
	
	logic [5:0] wires;
	
	//built 3:8 decoder from 7 1:2 decoders
	//1 1:2 to take in MSB of input and enable
	//2 1:2 to take in next set of input and outputs of other decoder to make intermediate output
	//4 1:2 to take in LSB's of input and intermediate outputs of previous decoders
	
	decoder1_2 d0 (.en(en), .in(in[2]), .out(wires[1:0]));
	
	decoder1_2 d1 (.en(wires[0]), .in(in[1]), .out(wires[3:2]));
	decoder1_2 d2 (.en(wires[1]), .in(in[1]), .out(wires[5:4]));
	
	decoder1_2 d3 (.en(wires[2]), .in(in[0]), .out(out[1:0]));
	decoder1_2 d4 (.en(wires[3]), .in(in[0]), .out(out[3:2]));
	decoder1_2 d5 (.en(wires[4]), .in(in[0]), .out(out[5:4]));
	decoder1_2 d6 (.en(wires[5]), .in(in[0]), .out(out[7:6]));
endmodule

module decoder3_8_testbench();
	logic [7:0] out;
	logic [2:0] in;
	logic en;
	
	decoder3_8 dut(.en, .in, .out);
	
	integer i;
	initial begin
		for (i = 0; i < 2**4; i++) begin
			{en, in} = i; #10;
		end
	end
endmodule
	