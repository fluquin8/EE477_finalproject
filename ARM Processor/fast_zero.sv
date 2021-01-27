`timescale 1ns/10ps


module fast_zero (result, speedyZero);
	input logic [63:0] result;
	output logic speedyZero;
    parameter delay = 0.05;
    logic [3:0] norTemp;
	
	//Routing result through 16x1 inverted NORs
	nor16_1 nor0 (.out(norTemp[0]), .in(result[15:0]));
    nor16_1 nor1 (.out(norTemp[1]), .in(result[31:16]));
    nor16_1 nor2 (.out(norTemp[2]), .in(result[47:32]));
    nor16_1 nor3 (.out(norTemp[3]), .in(result[63:48]));
	
	//NORing the result
	and #delay and1 (speedyZero, norTemp[0], norTemp[1], norTemp[2], norTemp[3]);
	
endmodule

module fast_zero_testbench();
    logic [63:0] result;
    logic speedyZero;

    fast_zero dut (.result, .speedyZero);

    initial begin
        result = 64'd0; #10;
        result = 64'd1; #10;
        result = 64'd2; #10;
    end
endmodule