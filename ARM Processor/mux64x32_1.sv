`timescale 1ns/10ps

module mux64x32_1(sel, in, out);    
	parameter width = 64;
	output logic [width-1:0] out;  
	input logic [4:0] sel;
	input logic [31:0][width-1:0] in;
	
	//cannot give input to mux32_1 as in[31:0][i]
	//because of some syntax requirement, we have to transpose the input
	//matrix 
	
	logic [width-1:0][31:0] in_transpose;
	integer ii, jj;
	always_comb begin
		for (ii = 0; ii < 32; ii++)
			for (jj = 0; jj < width; jj++)
				in_transpose[jj][ii] = in[ii][jj];
	end
	
	//use generate statement make 64 32:1 mux because original 32:1 mux 
	//is only 1-bit, so we basically deal with this bit by bit
	
	genvar i;
	generate
		for (i = 0; i < width; i++) begin : eachMUX
			mux32_1 m (.sel(sel), .in(in_transpose[i][31:0]), .out(out[i]));
		end
	endgenerate
endmodule    

module mux64x32_1_testbench();     
   parameter width = 64;
	parameter total_input = 32;
	logic [width-1:0] out;  
	logic [4:0] sel;
	logic [total_input-1:0][width-1:0] in;
	
	mux64x32_1 dut (.sel, .in, .out);   
	
	integer i, j;
	initial begin
		for (i = 0; i < total_input; i++) begin
			in[i][width-1:0] = 64'hA + i;
		end
	end
	initial begin
		for (j = 0; j < total_input; j++) begin
			sel = j; #10;
		end
	end 
endmodule
