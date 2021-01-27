`timescale 1ns/10ps

module cpustim();
    logic clk, reset;

    cpu dut (.reset, .clk);

    parameter delay = 20;
	 
	initial $timeformat(-9, 2, " ns", 10);

    initial begin // Set up the clock
		clk <= 0;
		forever #(delay/2) clk <= ~clk;
	end

    integer i;
	initial begin
        reset <= 1; @(posedge clk);
        reset <= 0; @(posedge clk);
        for (i = 0; i < 1500; i = i + 1) begin
            @(posedge clk);
        end
        $stop;
	end
endmodule
