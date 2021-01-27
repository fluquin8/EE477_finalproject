`timescale 1ns/10ps

module control_logic(opcode, negative, zero, overflow, carry_out,
                    xferSize, aluSrc, aluOP, 
                    uncondBr, brTaken, reg2Loc, regWrite, flagEn, memWrite, memToReg, memRead, isMOVZorMOVK, isLDURB);
    input logic [10:0] opcode;
    input logic negative, zero, overflow, carry_out;
    output logic [3:0] xferSize;
    output logic [1:0] aluSrc;
    output logic [2:0] aluOP;
    output logic uncondBr, brTaken, reg2Loc, regWrite, flagEn, memWrite, memToReg, memRead, isMOVZorMOVK, isLDURB;
    
    parameter [10:0] B = 11'b000101xxxxx,
				ADDI = 11'b1001000100x,
				ADDS = 11'b10101011000,
				SUBS = 11'b11101011000,
				BLT = 11'b01010100xxx,
				CBZ = 11'b10110100xxx,
				LDUR = 11'b11111000010,
				STUR = 11'b11111000000,
				LDURB = 11'b00111000010,
				STURB = 11'b00111000000,
				MOVK = 11'b111_1001_01xx,
				MOVZ = 11'b110_1001_01xx;

    always_comb begin
        casex(opcode)
            ADDI: begin
                 $display("ADDI reached");
                reg2Loc = 1'b1;
                aluSrc = 2'b11;
                memToReg = 1'b0;
                regWrite = 1'b1;
                memWrite = 1'b0;
                brTaken = 1'b0;
                uncondBr = 1'bx;
                aluOP = 3'b010;
                flagEn = 1'b0;
                xferSize = 4'bxxxx;
                isMOVZorMOVK = 1'bx;
                isLDURB = 1'b0;
                memRead = 1'b0;
            end
            ADDS: begin
                 $display("ADDS reached");
                reg2Loc = 1'b1;
                aluSrc = 2'b00;
                memToReg = 1'b0;
                regWrite = 1'b1;
                memWrite = 1'b0;
                brTaken = 1'b0;
                uncondBr = 1'bx;
                aluOP = 3'b010;
                flagEn = 1'b1;
                xferSize = 4'bxxxx;
                isMOVZorMOVK = 1'bx;
                isLDURB = 1'b0;
                memRead = 1'b0;
            end
            B: begin
                 $display("B reached");
                reg2Loc = 1'bx;
                aluSrc = 2'bxx;
                memToReg = 1'bx;
                regWrite = 1'b0;
                memWrite = 1'b0;
                brTaken = 1'b1;
                uncondBr = 1'b1;
                aluOP = 3'bxxx;
                flagEn = 1'b0;
                xferSize = 4'bxxxx;
                isMOVZorMOVK = 1'bx;
                isLDURB = 1'bx;
                memRead = 1'b0;
            end
            BLT: begin
                 $display("BLT reached");
                reg2Loc = 1'bx;
                aluSrc = 2'bxx;
                memToReg = 1'bx;
                regWrite = 1'b0;
                memWrite = 1'b0;
                brTaken =  negative ^ overflow;//BLTxor;
                uncondBr = 1'b0;
                aluOP = 3'bxxx;
                flagEn = 1'b0;
                xferSize = 4'bxxxx;
                isMOVZorMOVK = 1'bx;
                isLDURB = 1'bx;
                memRead = 1'b0;
            end
            CBZ: begin
                 $display("CBZ reached");
                reg2Loc = 1'b0;
                aluSrc = 2'b00;
                memToReg = 1'bx;
                regWrite = 1'b0;
                memWrite = 1'b0;
                brTaken = zero;
                uncondBr = 1'b0;
                aluOP = 3'b000;
                flagEn = 1'b0;
                xferSize = 4'bxxxx;
                isMOVZorMOVK = 1'bx;
                isLDURB = 1'bx;
                memRead = 1'b0;
            end
            LDUR: begin
                 $display("LDUR reached");
                reg2Loc = 1'bx;
                aluSrc = 2'b01;
                memToReg = 1'b1;
                regWrite = 1'b1;
                memWrite = 1'b0;
                brTaken = 1'b0;
                uncondBr = 1'bx;
                aluOP = 3'b010;
                flagEn = 1'b0;
                xferSize = 4'b1000;
                isMOVZorMOVK = 1'bx;
                isLDURB = 1'b0;
                memRead = 1'b1;
            end
            LDURB: begin
                 $display("LDURB reached");
                reg2Loc = 1'bx;
                aluSrc = 2'b01;
                memToReg = 1'b1;
                regWrite = 1'b1;
                memWrite = 1'b0;
                brTaken = 1'b0;
                uncondBr = 1'bx;
                aluOP = 3'b010;
                flagEn = 1'b0;
                xferSize = 4'b0001;
                isMOVZorMOVK = 1'bx;
                isLDURB = 1'b1;
                memRead = 1'b1;
            end
            MOVK: begin
                 $display("MOVK reached");
                reg2Loc = 1'b0;
                aluSrc = 2'b10;
                memToReg = 1'b0;
                regWrite = 1'b1;
                memWrite = 1'b0;
                brTaken = 1'b0;
                uncondBr = 1'bx;
                aluOP = 3'b000;
                flagEn = 1'b0;
                xferSize = 4'bxxxx;
                isMOVZorMOVK = 1'b1;
                isLDURB = 1'b0;
                memRead = 1'b0;
            end
            MOVZ: begin
                 $display("MOVZ reached");
                reg2Loc = 1'b0;
                aluSrc = 2'b10;
                memToReg = 1'b0;
                regWrite = 1'b1;
                memWrite = 1'b0;
                brTaken = 1'b0;
                uncondBr = 1'bx;
                aluOP = 3'b000;
                flagEn = 1'b0;
                xferSize = 4'bxxxx;
                isMOVZorMOVK = 1'b0;
                isLDURB = 1'b0;
                memRead = 1'b0;
            end
            STUR: begin
                 $display("STUR reached");
                reg2Loc = 1'b0;
                aluSrc = 2'b01;
                memToReg = 1'bx;
                regWrite = 1'b0;
                memWrite = 1'b1;
                brTaken = 1'b0;
                uncondBr = 1'bx;
                aluOP = 3'b010;
                flagEn = 1'b0;
                xferSize = 4'b1000;
                isMOVZorMOVK = 1'bx;
                isLDURB = 1'b0;
                memRead = 1'b0;
            end
            STURB: begin
                 $display("STURB reached");
                reg2Loc = 1'b0;
                aluSrc = 2'b01;
                memToReg = 1'bx;
                regWrite = 1'b0;
                memWrite = 1'b1;
                brTaken = 1'b0;
                uncondBr = 1'bx;
                aluOP = 3'b010;
                flagEn = 1'b0;
                xferSize = 4'b0001;
                isMOVZorMOVK = 1'bx;
                isLDURB = 1'b0;
                memRead = 1'b0;
            end
            SUBS: begin
                 $display("SUBS reached");
                reg2Loc = 1'b1;
                aluSrc = 2'b00;
                memToReg = 1'b0;
                regWrite = 1'b1;
                memWrite = 1'b0;
                brTaken = 1'b0;
                uncondBr = 1'bx;
                aluOP = 3'b011;
                flagEn = 1'b1;
                xferSize = 4'bxxxx;
                isMOVZorMOVK = 1'bx;
                isLDURB = 1'b0;
                memRead = 1'b0;
            end
        endcase
    end
endmodule
