`timescale 1ns/10ps

// register to store information between stages
// different info will have different width
// instr -> width = 32
// register info -> width = 5
// data -> width = 64
// control logics -> width = 1
module pipe_register #(parameter width = 1) (q, d, reset, clk);
	output logic [width-1:0] q;
	input logic [width-1:0] d;
	input logic clk;
	input logic reset;
	
	genvar i;
	generate
		for (i = 0; i < width; i++) begin : eachDFF
			D_FF d_ff (.q(q[i]), .d(d[i]), .reset, .clk);
		end
	endgenerate
endmodule

module pipe_register_1_testbench();
    parameter width = 1;
    logic [width-1:0] q;
    logic [width-1:0] d;
    logic clk, reset;

    pipe_register #(.width(width)) dut (.q, .d, .reset, .clk);

    parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end

    initial begin
        reset <= 1; @(posedge clk);
        reset <= 0; @(posedge clk);
        d <= 1'b0; @(posedge clk); @(posedge clk);
        @(posedge clk); @(posedge clk);
        d <= 1'b1; @(posedge clk); @(posedge clk);
        @(posedge clk); @(posedge clk);
		$stop;
    end
endmodule

module pipe_register_5_testbench();
    parameter width = 5;
    logic [width-1:0] q;
    logic [width-1:0] d;
    logic clk, reset;

    pipe_register #(.width(width)) dut (.q, .d, .reset, .clk);

    parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end

    initial begin
        reset <= 1; @(posedge clk);
        reset <= 0; @(posedge clk);
        d <= 5'b00000; @(posedge clk); @(posedge clk);
        @(posedge clk); @(posedge clk);
        d <= 5'b11111; @(posedge clk); @(posedge clk);
        @(posedge clk); @(posedge clk);
		$stop;
    end
endmodule

module pipe_register_32_testbench();
    parameter width = 32;
    logic [width-1:0] q;
    logic [width-1:0] d;
    logic clk, reset;

    pipe_register #(.width(width)) dut (.q, .d, .reset, .clk);

    parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end

    initial begin
        reset <= 1; @(posedge clk);
        reset <= 0; @(posedge clk);
        d <= 32'h1111; @(posedge clk); @(posedge clk);
        d <= 32'h0000; @(posedge clk); @(posedge clk);
		$stop;
    end
endmodule

module pipe_register_64_testbench();
    parameter width = 64;
    logic [width-1:0] q;
    logic [width-1:0] d;
    logic clk, reset;

    pipe_register #(.width(width)) dut (.q, .d, .reset, .clk);

    parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end

    initial begin
        reset <= 1; @(posedge clk);
        reset <= 0; @(posedge clk);
        d <= 64'h11111111; @(posedge clk); @(posedge clk);
        d <= 64'h00000000; @(posedge clk); @(posedge clk);
		$stop;
    end
endmodule