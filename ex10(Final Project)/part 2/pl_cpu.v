`include "./RegisterFile.v"
`include "./InstructionMemory.v"
`include "./AdderModules.v"
`include "./Mux2x1.v"
`include "./ALU.v"
`include "./ALUControl.v"
`include "./clock.v"
`include "./Control.v"
`include "./Data_Memory.v"

module pl-cpu (
        input Clk, 
        input Reset_N, 

	// Instruction memory interface
        output i_readM, 
        output reg i_writeM, 
        output [`WORD_SIZE-1:0] i_address, 
        inout [`WORD_SIZE-1:0] i_data, 

	// Data memory interface
        output d_readM, 
        output d_writeM, 
        output [`WORD_SIZE-1:0] d_address, 
        inout [`WORD_SIZE-1:0] d_data, 

        output [`WORD_SIZE-1:0] num_inst, 
        output [`WORD_SIZE-1:0] output_port, 
        output is_halted                      
);

   
    reg [`WORD_SIZE-1:0] internal_num_inst;     
    reg [`WORD_SIZE-1:0] jump_mispredict_penalty, branch_mispredict_penalty, stall_penalty;
    
    reg [`WORD_SIZE-1:0] PC, nextPC;
    
    // IF/ID pipeline registers. no control signals
    reg [`WORD_SIZE-1:0] IF_ID_Inst, IF_ID_PC, IF_ID_nextPC;
    
    reg [`WORD_SIZE-1:0] ID_EX_RFRead1, ID_EX_RFRead2, ID_EX_SignExtendedImm, ID_EX_PC, ID_EX_nextPC;
    reg [1:0] ID_EX_RFWriteAddress;
    // control signals
    reg ID_EX_IsBranch, ID_EX_ALUSrcA, ID_EX_DataMemRead, ID_EX_DataMemWrite, ID_EX_RegWrite, ID_EX_Halt, ID_EX_RegSrc;
    reg [1:0] ID_EX_RegDst, ID_EX_ALUSrcB;
    reg [3:0] ID_EX_ALUOp;
    
    reg [`WORD_SIZE-1:0] EX_MEM_RFRead2, EX_MEM_PC, EX_MEM_ALUResult;
    reg [1:0] EX_MEM_RFWriteAddress;
    
    reg EX_MEM_DataMemRead, EX_MEM_DataMemWrite, EX_MEM_RegWrite, EX_MEM_RegSrc;
   
    reg [`WORD_SIZE-1:0] MEM_WB_RFRead2, MEM_WB_MemData, MEM_WB_ALUResult;
    reg [1:0] MEM_WB_RFWriteAddress;
   
    reg MEM_WB_RegWrite, MEM_WB_RegSrc;
    
    wire IsBranch, IsJump, JumpType, DataMemRead, DataMemWrite, RegWrite, PCWrite, IFIDWrite, IFFlush, IDEXWrite, ALUSrcA, RegSrc, Halt, OpenPort;
    wire [1:0] RegDst, ALUSrcB;
    wire [3:0] ALUOp;
    
    // Data hazard detection
    wire BranchMisprediction, JumpMisprediction, Stall;
    
    // Branch Prediction
    wire [`WORD_SIZE-1:0] ActualBranchTarget, Prediction;
    wire Correct;
    
    // RF
    reg [`WORD_SIZE-1:0] WriteData;
    wire [`WORD_SIZE-1:0] RFRead1, RFRead2;
    
    // ALU
    reg [`WORD_SIZE-1:0] ALUin1, ALUin2;
    wire [`WORD_SIZE-1:0] ALUResult;
    wire BranchTaken;
    
    Control control (.opcode(IF_ID_Inst[15:12]),
                     .func(IF_ID_Inst[5:0]),
                     .BranchMisprediction(BranchMisprediction),
                     .JumpMisprediction(JumpMisprediction),
                     .Stall(Stall),
                     .IsBranch(IsBranch),
                     .IsJump(IsJump),
                     .JumpType(JumpType),
                     .DataMemRead(DataMemRead),
                     .DataMemWrite(DataMemWrite),
                     .RegWrite(RegWrite),
                     .PCWrite(PCWrite),
                     .IFIDWrite(IFIDWrite),
                     .IFFlush(IFFlush),
                     .IDEXWrite(IDEXWrite),
                     .RegSrc(RegSrc),
                     .ALUSrcA(ALUSrcA),
                     .Halt(Halt),
                     .OpenPort(OpenPort),
                     .RegDst(RegDst),
                     .ALUSrcB(ALUSrcB),
                     .ALUOp(ALUOp));
    
    // Hazard Detector module is located at the ID stage.
    HazardDetector hazard_detector (.inst(IF_ID_Inst), 
                                    .ID_EX_RFWriteAddress(ID_EX_RFWriteAddress),
                                    .EX_MEM_RFWriteAddress(EX_MEM_RFWriteAddress),
                                    .MEM_WB_RFWriteAddress(MEM_WB_RFWriteAddress),
                                    .ID_EX_RegWrite(ID_EX_RegWrite),
                                    .EX_MEM_RegWrite(EX_MEM_RegWrite),
                                    .MEM_WB_RegWrite(MEM_WB_RegWrite),
                                    .Stall(Stall));
    
    // Branch Predictor module is located at the IF stage.
    AlwaysNTPredictor branch_predictor (.PC(PC),
                                        .Correct(Correct),
                                        .ActualBranchTarget(ActualBranchTarget),
                                        .Prediction(Prediction));

    RF rf (.write(MEM_WB_RegWrite),
           .clk(Clk),
           .reset_n(Reset_N),
           .addr1(IF_ID_Inst[11:10]),
           .addr2(IF_ID_Inst[9:8]),
           .addr3(MEM_WB_RFWriteAddress),
           .data1(RFRead1),
           .data2(RFRead2),
           .data3(WriteData));
    
    ALU alu (.A(ALUin1),
             .B(ALUin2),
             .OP(ID_EX_ALUOp),
             .C(ALUResult),
             .branch_cond(BranchTaken));
   
    always @(posedge Clk) begin
        if (!Reset_N) begin     // Synchronous active-low reset
            PC <= 0;
            internal_num_inst <= 0;
            jump_mispredict_penalty <= 0;
            branch_mispredict_penalty <= 0;
            stall_penalty <= 0;
        end
    end
  
    always @(posedge Clk) begin
        if (Reset_N) begin     // Synchronous active-low reset
        // IF/ID registers
            if (IFIDWrite | internal_num_inst==0) begin
                IF_ID_PC      <= PC;
                IF_ID_nextPC  <= nextPC;
            end else if (IFFlush) begin
                IF_ID_Inst    <= `WORD_SIZE'hffff;
                IF_ID_PC      <= 0;
                IF_ID_nextPC  <= 0;
            end
       
            if (IDEXWrite) begin
                case (RegDst)
                    2'b00: ID_EX_RFWriteAddress <= IF_ID_Inst[9:8];
                    2'b01: ID_EX_RFWriteAddress <= IF_ID_Inst[7:6];
                    2'b10: ID_EX_RFWriteAddress <= 2'b10;
                    default: begin end
                endcase
                ID_EX_SignExtendedImm   <= {{8{IF_ID_Inst[7]}}, IF_ID_Inst[7:0]};
                ID_EX_RFRead1           <= RFRead1;
                ID_EX_RFRead2           <= RFRead2;
                ID_EX_PC                <= IF_ID_PC;
                ID_EX_nextPC            <= IF_ID_nextPC;
                ID_EX_IsBranch          <= IsBranch;
                ID_EX_ALUSrcA           <= ALUSrcA;
                ID_EX_ALUSrcB           <= ALUSrcB;
                ID_EX_DataMemRead       <= DataMemRead; 
                ID_EX_DataMemWrite      <= DataMemWrite;
                ID_EX_RegWrite          <= RegWrite;
                ID_EX_RegSrc            <= RegSrc;
                ID_EX_RegDst            <= RegDst;
                ID_EX_ALUOp             <= ALUOp;
                ID_EX_Halt              <= Halt;
            end else begin
                ID_EX_RFWriteAddress    <= 0;
                ID_EX_PC                <= 0;
                ID_EX_nextPC            <= 0;
                ID_EX_IsBranch          <= 0;
                ID_EX_DataMemRead       <= 0;
                ID_EX_DataMemWrite      <= 0;
                ID_EX_RegWrite          <= 0;
                ID_EX_Halt              <= 0;
            end
        
            EX_MEM_RFRead2        <= ID_EX_RFRead2;
            EX_MEM_PC             <= ID_EX_PC;
            EX_MEM_ALUResult      <= ALUResult;
            EX_MEM_RFWriteAddress <= ID_EX_RFWriteAddress;
            EX_MEM_DataMemRead    <= ID_EX_DataMemRead;
            EX_MEM_DataMemWrite   <= ID_EX_DataMemWrite;
            EX_MEM_RegWrite       <= ID_EX_RegWrite;
            EX_MEM_RegSrc         <= ID_EX_RegSrc;
        
            MEM_WB_RFRead2        <= EX_MEM_RFRead2;
            MEM_WB_RFWriteAddress <= EX_MEM_RFWriteAddress;
            MEM_WB_RegWrite       <= EX_MEM_RegWrite;
            MEM_WB_RegSrc         <= EX_MEM_RegSrc;
            MEM_WB_ALUResult      <= EX_MEM_ALUResult;
        end
    end
  
    
    assign output_port = OpenPort ? RFRead1 : `WORD_SIZE'bz;
    
  
    assign is_halted = ID_EX_Halt;
    
    assign num_inst = OpenPort ? (internal_num_inst - branch_mispredict_penalty - stall_penalty - jump_mispredict_penalty) : `WORD_SIZE'b0;
    always @(posedge Clk) begin
        if (Reset_N) internal_num_inst <= internal_num_inst + 1;
    end
    always @(negedge Clk) begin     // Used negedge because of glitches in the signals at transition yielded random increments
        if (BranchMisprediction)    branch_mispredict_penalty  <= branch_mispredict_penalty + 2;
        else if (Stall)             stall_penalty              <= stall_penalty + 1;
        else if (JumpMisprediction) jump_mispredict_penalty    <= jump_mispredict_penalty + 1;
    end
  
    assign i_address = (IFIDWrite | internal_num_inst==0) ? PC : `WORD_SIZE'bz;
    assign i_readM = (IFIDWrite | internal_num_inst==0) ? 1 : 0;
    
    // When the IF stage needs to be flushed, discard the fetched instruction.
    // Else, fetch instruction directly into the pipeline register.
    always @(posedge Clk) begin
        if (IFFlush) IF_ID_Inst <= `WORD_SIZE'hffff;
        // No control signals during the IF stage of the first instruction. Manually enable IF/ID pipeline register write,
        else if (IFIDWrite | internal_num_inst==0) IF_ID_Inst <= i_data;
    end
    
    // Data memory access
    assign d_data = (EX_MEM_DataMemWrite) ? EX_MEM_RFRead2 : `WORD_SIZE'bz;
    assign d_readM = EX_MEM_DataMemRead;
    assign d_writeM = EX_MEM_DataMemWrite;
    assign d_address = (EX_MEM_DataMemRead || EX_MEM_DataMemWrite) ? EX_MEM_ALUResult : `WORD_SIZE'bz;
    
    // Fetch data directly into the pipeline register.
    always @(posedge Clk) begin
        if (EX_MEM_DataMemRead) MEM_WB_MemData <= d_data;
    end
 
    always @(*) begin
        if (ID_EX_IsBranch & BranchMisprediction) begin
            if (BranchTaken) nextPC = ID_EX_PC + 1 + ID_EX_SignExtendedImm;  // Branch should have been taken
            else nextPC = ID_EX_PC + 1;                                      // Branch shouldn't have been taken
        end else if (IsJump & JumpMisprediction) begin
            if (JumpType) nextPC = RFRead1;                     // JPR, JRL
            else nextPC = {IF_ID_PC[15:12], IF_ID_Inst[11:0]};  // JMP, JAL
        end else begin
            nextPC = Prediction;    // by the branch_predictor. Always PC+1 in the baseline model.
        end
    end
    
    // Update PC at clock posedge
    always @(posedge Clk) begin
        if (Reset_N) 
            // No control signals before the ID stage of the first instruction. Manually enable PCwrite,
            if (PCWrite | internal_num_inst==0) PC <= nextPC;
    end
   
    always @(*) begin
        case (MEM_WB_RegSrc)
            0: WriteData = MEM_WB_ALUResult;
            1: WriteData = MEM_WB_MemData;
            default: begin end
        endcase
    end
  
    always @(*) begin
        case (ID_EX_ALUSrcA)
            0: ALUin1 = ID_EX_RFRead1;
            1: ALUin1 = ID_EX_PC;
        endcase
    end
    always @(*) begin
        case (ID_EX_ALUSrcB)
            0: ALUin2 = ID_EX_RFRead2;
            1: ALUin2 = ID_EX_SignExtendedImm;
            2: ALUin2 = 1;
            default: begin end
        endcase
    end
    
    assign BranchMisprediction = ID_EX_IsBranch && ((BranchTaken && ID_EX_nextPC!=ALUResult) || (!BranchTaken && ID_EX_nextPC!=ID_EX_PC+1));
    assign JumpMisprediction = IsJump && ((JumpType && RFRead1!=IF_ID_nextPC) || (!JumpType && {IF_ID_PC[15:12], IF_ID_Inst[11:0]}!=IF_ID_nextPC));
  
    
endmodule