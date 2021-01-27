`timescale 1ns/10ps

module mux8_1(sel, in, out);    
	output logic out;  
	input logic [2:0] sel;
	input logic [7:0] in;

	logic [1:0] wires;     
	
	mux4_1 m0 (.sel(sel[1:0]), .in(in[3:0]), .out(wires[0]));
	mux4_1 m1 (.sel(sel[1:0]), .in(in[7:4]), .out(wires[1]));

	mux2_1 m (.sel(sel[2]), .in(wires[1:0]), .out(out));
endmodule  

module mux8_1_testbench();     
   logic out;
	logic [2:0] sel;
	logic [7:0] in;
	
	mux8_1 dut (.sel, .in, .out);   
	
	integer i;
	initial begin
		for (i = 0; i < 2**11; i++) begin
			{sel, in} = i; #10;
		end
	end 
endmodule