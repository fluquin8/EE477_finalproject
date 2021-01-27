`timescale 1ns/10ps

module flag_register (q, out, d, en, clk);
    input logic d, en, clk;
    output logic q, out;
    logic muxResult;
    logic [1:0] in;

    assign in[0] = q;
    assign in[1] = d;

    D_FF flagff (.q(q), .d(muxResult), .reset(1'b0), .clk);
    mux2_1 mux_ff (.sel(en), .in(in), .out(muxResult));

    // mux2_1 mux_out (.sel(en), .in(in), .out())
    assign out = muxResult;
endmodule

module flag_register_testbench();
    logic q, out, d, en, clk;

    flag_register dut (.q, .out, .d, .en, .clk);

    parameter clock_period = 100;
	initial begin
		clk <= 0;
		forever #(clock_period / 2) clk <= ~clk;
	end

    initial begin
        en = 0;
        d <= 1'b0; @(posedge clk); @(posedge clk);
        @(posedge clk); @(posedge clk);
        d <= 1'b1; @(posedge clk); @(posedge clk);
        @(posedge clk); @(posedge clk);
        en = 1;
        d <= 1'b0; @(posedge clk); @(posedge clk);
        @(posedge clk); @(posedge clk);
        d <= 1'b1; @(posedge clk); @(posedge clk);
        @(posedge clk); @(posedge clk);
		$stop;
    end
endmodule
