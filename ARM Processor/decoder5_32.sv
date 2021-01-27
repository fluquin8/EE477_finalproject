`timescale 1ns/10ps

module decoder5_32(en, in, out);
	output logic [31:0] out;
	input logic [4:0] in;
	input logic en;
	
	logic [3:0] wires;
	
	//built 5:32 decoder from 1 2:4 and 4 3:8 decoders
	//use same hierarchy ideas as other smaller decoders
	
	decoder2_4 d0 (.en(en), .in(in[4:3]), .out(wires));
	
	decoder3_8 d1 (.en(wires[0]), .in(in[2:0]), .out(out[7:0]));
	decoder3_8 d2 (.en(wires[1]), .in(in[2:0]), .out(out[15:8]));
	decoder3_8 d3 (.en(wires[2]), .in(in[2:0]), .out(out[23:16]));
	decoder3_8 d4 (.en(wires[3]), .in(in[2:0]), .out(out[31:24]));
endmodule

module decoder5_32_testbench();
	logic [31:0] out;
	logic [4:0] in;
	logic en;
	
	decoder5_32 dut(.en, .in, .out);
	
	integer i;
	initial begin
		for (i = 0; i < 2**6; i++) begin
			{en, in} = i; #10;
		end
	end
endmodule
