`timescale 1ns/10ps

module mux16_1(sel, in, out);    
	output logic out;  
	input logic [3:0] sel;
	input logic [15:0] in;

	logic [3:0] wires;     
	
	//make 16:1 mux by combining 5 4:1 mux
	//4 4:1 for the in values
	//1 4:1 for making the out value

	mux4_1 m0 (.sel(sel[1:0]), .in(in[3:0]), .out(wires[0]));
	mux4_1 m1 (.sel(sel[1:0]), .in(in[7:4]), .out(wires[1]));
	mux4_1 m2 (.sel(sel[1:0]), .in(in[11:8]), .out(wires[2]));
	mux4_1 m3 (.sel(sel[1:0]), .in(in[15:12]), .out(wires[3]));

	mux4_1 m (.sel(sel[3:2]), .in(wires[3:0]), .out(out));
endmodule    

module mux16_1_testbench();     
   logic out;
	logic [3:0] sel;
	logic [15:0] in;
	
	mux16_1 dut (.sel, .in, .out);   
	
	integer i;
	initial begin
		for (i = 0; i < 2**20; i++) begin
			{sel, in} = i; #10;
		end
	end 
endmodule