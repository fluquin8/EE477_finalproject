`timescale 1ns/10ps

module regfile(ReadData1, ReadData2, WriteData,
					ReadRegister1, ReadRegister2, WriteRegister,
					RegWrite, clk);
	input logic RegWrite;
	input logic [4:0] WriteRegister;
	input logic [63:0] WriteData;
	input logic [4:0] ReadRegister1, ReadRegister2;
	output logic [63:0] ReadData1, ReadData2;
	input logic clk;
	
    logic inverted_clk;
	not #0.05 invertor (inverted_clk, clk);
	
	logic [31:0] dec_out;
	decoder5_32 dec (.en(RegWrite), .in(WriteRegister), .out(dec_out));
	
	logic [31:0][63:0] regis;
	assign regis[31][63:0] = 64'b0;
	genvar r;
	generate
		for (r = 0; r < 31; r++) begin : eachRegister
			register re (.q(regis[r][63:0]), .d(WriteData), .en(dec_out[r]), .clk(inverted_clk));
		end
	endgenerate
	
	mux64x32_1 m1 (.sel(ReadRegister1), .in(regis), .out(ReadData1));
	mux64x32_1 m2 (.sel(ReadRegister2), .in(regis), .out(ReadData2));

endmodule
