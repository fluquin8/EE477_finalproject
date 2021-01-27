`timescale 1ns/10ps

module mux32_1(sel, in, out);    
	output logic out;  
	input logic [4:0] sel;
	input logic [31:0] in;

	logic [1:0] wires;     
	
	//make 32:1 mux by combining 1 2:1 and 2 16:1 mux
	//2 16:1 for the in values
	//1 2:1 for making the out value
	

	mux16_1 m0 (.sel(sel[3:0]), .in(in[15:0]), .out(wires[0]));
	mux16_1 m1 (.sel(sel[3:0]), .in(in[31:16]), .out(wires[1]));

	mux2_1 m (.sel(sel[4]), .in(wires[1:0]), .out(out));
endmodule    

module mux32_1_testbench();     
   logic out;
	logic [4:0] sel;
	logic [31:0] in;
	
	mux32_1 dut (.sel, .in, .out);   
	
	time i;
	initial begin
		for (i = 0; i < 2**37; i++) begin
			{in, sel} = i; #10;
		end
	end 
endmodule
