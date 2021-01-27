`timescale 1ns/10ps

module mux4_1(sel, in, out);    
	output logic out;  
	input logic [1:0] sel;
	input logic [3:0] in;

	logic [1:0] wires;     

	//make 4:1 mux by combining 3 2:1 mux
	//2 2:1 for the in values
	//1 2:1 for making the out value
	
	mux2_1 m0 (.sel(sel[0]), .in(in[1:0]), .out(wires[0]));
	mux2_1 m1 (.sel(sel[0]), .in(in[3:2]), .out(wires[1]));

	mux2_1 m (.sel(sel[1]), .in(wires[1:0]), .out(out));
endmodule    

module mux4_1_testbench();     
   logic out;
	logic [1:0] sel;
	logic [3:0] in;
	
	mux4_1 dut (.sel, .in, .out);   
	
	integer i;
	initial begin
		for (i = 0; i < 2**6; i++) begin
			{sel, in} = i; #10;
		end
	end 
endmodule
