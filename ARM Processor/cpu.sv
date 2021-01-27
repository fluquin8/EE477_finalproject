`timescale 1ns/10ps

module cpu (reset, clk);
    input logic reset, clk;

    logic [31:0] instructionIF, instructionRF;
    logic [4:0] RdRF, RdEX, RdMEM, RdWB;
    logic [4:0] Rn, Rm;
    logic [63:0] DwMEM, DwWB; 
    logic [63:0] DbRF, DbEX, DbMEM;
    logic [63:0] forwardedALU_A_RF, forwardedALU_A_EX; 
    logic [63:0] forwardedALU_B_RF, forwardedALU_B_EX;
    logic uncondBr;
    logic [2:0] aluOpRF, aluOpEX;
    logic brTaken;
    logic reg2Loc;
    logic regWriteRF, regWriteEX, regWriteMEM, regWriteWB;
    logic flagEnRF, flagEnEX;
    logic memWriteRF, memWriteEX, memWriteMEM, memWriteWB;
    logic memToRegRF, memToRegEX, memToRegMEM, memToRegWB;
    logic memReadRF, memReadEX, memReadMEM, memReadWB;
    logic isMOVZorMOVK;
    logic isLDURB_RF, isLDURB_EX, isLDURB_MEM;
    logic [10:0] opcode;
    logic [1:0] shamt;
    logic [11:0] imm12;
    logic [8:0] dAddr9;
    logic [15:0] imm16;
    logic [25:0] brAddr26;
    logic [18:0] condAddr19;
    logic [1:0] aluSrc;
    logic [3:0] xferSizeRF, xferSizeEX, xferSizeMEM;
    logic [63:0] aluResultEX, aluResultMEM;
    logic [1:0] forwardA, forwardB, forwardData;
    logic negative, zero, overflow, carry_out;
    logic negative_flag, zero_flag, overflow_flag, carry_out_flag;
    logic speedyZero, speedyNegative, speedyOverflow, speedyCarryout;

    assign RdRF = 	 	instructionRF[4:0];
    assign Rn = 	 	instructionRF[9:5];
    assign Rm = 	 	instructionRF[20:16];
    assign opcode = 	instructionRF[31:21];
    assign shamt =  	instructionRF[22:21];
    assign imm12 =  	instructionRF[21:10];
    assign dAddr9 = 	instructionRF[20:12];
    assign imm16 =      instructionRF[20:5];
    assign brAddr26 =   instructionRF[25:0];
    assign condAddr19 = instructionRF[23:5];


    // control logic
    control_logic theControlLogic (.opcode(opcode), .negative(speedyNegative), .zero(speedyZero), .overflow(speedyOverflow), .carry_out(carry_out_flag),
                                    .xferSize(xferSizeRF), .aluSrc(aluSrc), .aluOP(aluOpRF), 
                                    .uncondBr, .brTaken, .reg2Loc, .regWrite(regWriteRF), .flagEn(flagEnRF), .memWrite(memWriteRF), 
                                    .memToReg(memToRegRF), .memRead(memReadRF), .isMOVZorMOVK, .isLDURB(isLDURB_RF));
    
    // ------ IF stage ------
    // program counting and instruction fetching
    logic [63:0] currentPC_IF, currentPC_RF, currentPC, newNormalPC, newBranchPC, newPC;

    instructmem instructionMemory (.address(currentPC_IF), .instruction(instructionIF), .clk(clk));

    mux2_1_64bit findCurrentPCmux (.sel(brTaken), .in({currentPC_RF, currentPC_IF}), .out(currentPC));

    fulladder_64bit normalAdder (.sum(newNormalPC), .A(currentPC), .B(64'd4));

    logic [63:0] extended_condAddr19, extended_brAddr26, shiftLeft2_uncondBrMuxResult;
    sign_extend #(.width(19)) condAddr19SE (.out(extended_condAddr19), .in(condAddr19));
    sign_extend #(.width(26)) brAddr26SE (.out(extended_brAddr26), .in(brAddr26));

    logic [63:0] uncondBrMuxResult;
    mux2_1_64bit uncondBrMux (.sel(uncondBr), .in({extended_brAddr26, extended_condAddr19}), .out(uncondBrMuxResult));
    assign shiftLeft2_uncondBrMuxResult = {uncondBrMuxResult[61:0], 2'b00};
    fulladder_64bit branchAdder (.sum(newBranchPC), .A(currentPC), .B(shiftLeft2_uncondBrMuxResult));

    mux2_1_64bit brTakenMux (.sel(brTaken), .in({newBranchPC, newNormalPC}), .out(newPC));

    pc programCounter (.out(currentPC_IF), .in(newPC), .clk(clk), .reset(reset));

    // ------ IF-RF pipe stage ------
    pipe_register #(.width(32)) instructionCarrierIF_RF (.q(instructionRF), .d(instructionIF), .reset, .clk); 
    pipe_register #(.width(64)) pcCarrierIF_RF (.q(currentPC_RF), .d(currentPC_IF), .reset, .clk);

    // ------ RF stage ------
    logic [63:0] rawDa, rawDb;
    logic [4:0] Ab;
    
    forwarding_unit forwarder (.forwardA, .forwardB, .forwardData,
                                .branch(brTaken), .ALUSrc(aluSrc), 
                                .flagEnEX, .regWriteEX, .regWriteMEM, 
                                .RdEX, .RdMEM, .Rm(Ab), .Rn);
    
    mux2_1_5bit reg2LocMux (.sel(reg2Loc), .in({Rm, RdRF}), .out(Ab));
    regfile rf (.ReadData1(rawDa), .ReadData2(rawDb), .WriteData(DwWB),
				.ReadRegister1(Rn), .ReadRegister2(Ab), .WriteRegister(RdWB),
				.RegWrite(regWriteWB), .clk(clk));
        
    logic [63:0] extended_dAddr9, extended_imm12;
    sign_extend #(.width(9)) dAddr9SE (.out(extended_dAddr9), .in(dAddr9));
    zero_extend #(.width(12)) imm12ZE (.out(extended_imm12), .in(imm12));

    logic [63:0] replacee_input, mov_shifted_result;
    mux2_1_64bit isMOVZorMOVKmux (.sel(isMOVZorMOVK), .in({DbRF, 64'd0}), .out(replacee_input));
    mov_shifter ms (.out(mov_shifted_result), .imm(imm16), .replacee(replacee_input), .shift(shamt));

    logic [63:0] alusrc_output;
    mux4_1_64bit alusrcMux (.sel(aluSrc), .in({extended_imm12, mov_shifted_result, extended_dAddr9, rawDb}), .out(alusrc_output));

    //forwarder
    mux4_1_64bit forwardingAmux (.sel(forwardA), .in({64'hx, aluResultEX, DwMEM, rawDa}), .out(forwardedALU_A_RF));
    mux4_1_64bit forwardingBmux (.sel(forwardB), .in({64'hx, aluResultEX, DwMEM, alusrc_output}), .out(forwardedALU_B_RF));
    mux4_1_64bit forwardingDatamux (.sel(forwardData), .in({64'hx, aluResultEX, DwMEM, rawDb}), .out(DbRF));

    // ------ RF-EX pipe stage ------
    pipe_register #(.width(5)) RdCarrierRF_EX (.q(RdEX), .d(RdRF), .reset, .clk);
    pipe_register #(.width(3)) ALUOpCarrierRF_EX (.q(aluOpEX), .d(aluOpRF), .reset, .clk);
    pipe_register #(.width(1)) regWriteCarrierRF_EX (.q(regWriteEX), .d(regWriteRF), .reset, .clk);
    pipe_register #(.width(1)) flagEnCarrierRF_EX (.q(flagEnEX), .d(flagEnRF), .reset, .clk);
    pipe_register #(.width(1)) memWriteCarrierRF_EX (.q(memWriteEX), .d(memWriteRF), .reset, .clk);
    pipe_register #(.width(1)) memToRegCarrierRF_EX (.q(memToRegEX), .d(memToRegRF), .reset, .clk);
    pipe_register #(.width(1)) memReadCarrierRF_EX (.q(memReadEX), .d(memReadRF), .reset, .clk);
    pipe_register #(.width(1)) isldurbCarrierRF_EX (.q(isLDURB_EX), .d(isLDURB_RF), .reset, .clk);
    pipe_register #(.width(4)) xferSizeCarrierRF_EX (.q(xferSizeEX), .d(xferSizeRF), .reset, .clk);
    pipe_register #(.width(64)) aluACarrierRF_EX (.q(forwardedALU_A_EX), .d(forwardedALU_A_RF), .reset, .clk);
    pipe_register #(.width(64)) aluBCarrierRF_EX (.q(forwardedALU_B_EX), .d(forwardedALU_B_RF), .reset, .clk);
    pipe_register #(.width(64)) DbCarrierRF_EX (.q(DbEX), .d(DbRF), .reset, .clk);

    // ------ EX stage ------
    alu theALU (.A(forwardedALU_A_EX), .B(forwardedALU_B_EX), .control(aluOpEX), .result(aluResultEX), 
                .negative, .zero, .overflow, .carry_out);

    fast_zero getZeroFast (.result(forwardedALU_B_RF), .speedyZero);

    logic junk;
    flag_register negative_ff (.q(negative_flag), .out(speedyNegative), .d(negative), .en(flagEnEX), .clk);
    flag_register zero_ff (.q(zero_flag), .out(junk), .d(zero), .en(flagEnEX), .clk);
    flag_register overflow_ff (.q(overflow_flag), .out(speedyOverflow), .d(overflow), .en(flagEnEX), .clk);
    flag_register carryout_ff (.q(carry_out_flag), .out(speedyCarryout), .d(carry_out), .en(flagEnEX), .clk);

    // ------ EX-MEM pipe stage ------
    pipe_register #(.width(64)) DbCarrierEX_MEM (.q(DbMEM), .d(DbEX), .reset, .clk);
    pipe_register #(.width(5)) RdCarrierEX_MEM (.q(RdMEM), .d(RdEX), .reset, .clk);
    pipe_register #(.width(1)) regWriteCarrierEX_MEM (.q(regWriteMEM), .d(regWriteEX), .reset, .clk);
    pipe_register #(.width(1)) memWriteCarrierEX_MEM (.q(memWriteMEM), .d(memWriteEX), .reset, .clk);
    pipe_register #(.width(1)) memToRegCarrierEX_MEM (.q(memToRegMEM), .d(memToRegEX), .reset, .clk);
    pipe_register #(.width(1)) memReadCarrierEX_MEM (.q(memReadMEM), .d(memReadEX), .reset, .clk);
    pipe_register #(.width(1)) isldurbCarrierEX_MEM (.q(isLDURB_MEM), .d(isLDURB_EX), .reset, .clk);
    pipe_register #(.width(4)) xferSizeCarrierEX_MEM (.q(xferSizeMEM), .d(xferSizeEX), .reset, .clk);
    pipe_register #(.width(64)) aluResultCarrierEX_MEM (.q(aluResultMEM), .d(aluResultEX), .reset, .clk);

    // ------ MEM stage ------
    logic [63:0] datamem_output, datamem_output2;
    datamem dataMemory (.address(aluResultMEM), .write_enable(memWriteMEM), .read_enable(memReadMEM), .write_data(DbMEM),
	                    .clk(clk), .xfer_size(xferSizeMEM), .read_data(datamem_output));

    logic [63:0] regfile_datawrite_input_LDURB;
    zero_extend #(.width(8)) ldurb_byteZE (.out(regfile_datawrite_input_LDURB), .in(datamem_output[7:0]));
    mux2_1_64bit isLDURBmux (.sel(isLDURB_MEM), .in({regfile_datawrite_input_LDURB, datamem_output}), .out(datamem_output2));

    mux2_1_64bit memToRegMux (.sel(memToRegMEM), .in({datamem_output2, aluResultMEM}), .out(DwMEM));

    // ------ MEM-WB pipe stage ------
    pipe_register #(.width(5)) RdCarrierMEM_WB (.q(RdWB), .d(RdMEM), .reset, .clk);
    pipe_register #(.width(1)) regWriteCarrierMEM_WB (.q(regWriteWB), .d(regWriteMEM), .reset, .clk);
    pipe_register #(.width(64)) DwCarrierMEM_WB (.q(DwWB), .d(DwMEM), .reset, .clk);

    // ------ WB stage ------
    
    // nothing explicit here, just wiring in previous non-pipe stages
    

endmodule
