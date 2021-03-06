`timescale 1ns/10ps

module register (q, d, en, clk);
	parameter width = 64;
	output logic [width-1:0] q;
	input logic [width-1:0] d;
	input logic clk;
	input logic en;
	
	logic [width-1:0] mux_out;
	
	//use generate statement to generate all 64 bits for this register
	//each iteration only take care of 1 bit
	
	//use 2:1 in conjunction with D_FF to make a D flip-flop with enable capability

	//reset of D_FF is permanently off because there is no reset requirement
	
	genvar i;
	generate
		for (i = 0; i < width; i++) begin : eachDFF
			mux2_1 m (.sel(en), .in({d[i], q[i]}), .out(mux_out[i]));
			D_FF d_ff (.q(q[i]), .d(mux_out[i]), .reset(1'b0), .clk);
		end
	endgenerate
endmodule

module register_testbench();
	parameter width = 64;
	logic [width-1:0] q;
	logic [width-1:0] d;
	logic clk;
	logic en;
	
	register dut(.q, .d, .en, .clk);
	
	parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end
	
	initial begin
		en <= 1; d <= 64'h0;		@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		d <= 64'h1;					@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		en <= 0; d <= 64'ha;		@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		d <= 64'hf;					@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		en <= 1; d <= 64'h10;	@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		$stop;
	end
endmodule
