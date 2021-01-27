`timescale 1ns/10ps

module forwarding_unit(forwardA, forwardB, forwardData, 
                       branch, ALUSrc, 
                       flagEnEX, regWriteEX, regWriteMEM, 
                       RdEX, RdMEM, Rm, Rn);

    input logic [4:0] RdEX, RdMEM, Rm, Rn;
    input logic [1:0] ALUSrc;
    input logic branch, flagEnEX, regWriteEX, regWriteMEM;
    output logic [1:0] forwardA, forwardB, forwardData;

    always_comb begin
        if (regWriteEX & (RdEX != 5'd31) & (RdEX == Rn)) begin
            forwardA = 2'b10;
            end
        else if (regWriteMEM & (RdMEM != 5'd31) & (RdMEM == Rn)) begin
            forwardA = 2'b01;
            end
        else begin
            forwardA = 2'b00;
            end

        if (regWriteEX & (RdEX != 5'd31) & (RdEX == Rm) & (ALUSrc == 2'b00)) begin
            forwardB = 2'b10;
            end
        else if (regWriteMEM & (RdMEM != 5'd31) & (RdMEM == Rm) & (ALUSrc == 2'b00)) begin
            forwardB = 2'b01;
            end
        else begin
            forwardB = 2'b00;
            end

        if (regWriteEX & (RdEX != 5'd31) & (RdEX == Rm)) begin
            forwardData = 2'b10;
            end
        else if (regWriteMEM & (RdMEM != 5'd31) & (RdMEM == Rm)) begin
            forwardData = 2'b01;
            end
        else begin
            forwardData = 2'b00;
            end
            
    end

endmodule