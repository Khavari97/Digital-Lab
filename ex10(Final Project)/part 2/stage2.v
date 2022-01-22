
module stage2
 (clk,regWrite,pc,instruction,writeData,writeAd,
readData1,readData2,PC,immediate,rd,ALUcontrol,control,R1,R2);
    parameter Width = 32;
    input [Width-1:0]instruction,pc,writeData;
    input clk,regWrite;
    input [4:0] writeAd;
   

   output [Width-1:0] readData1,readData2,PC;
   output [63:0] immediate;
   output [4:0] rd;
   output [3:0] ALUcontrol;
   output [7:0] control;
   output [4:0] R1,R2;


   wire [Width-1:0] read1,read2;
   wire [63:0] immediateOut;
   wire [1:0] Aluop;
   wire ALUSrc,MemtoReg,Regwrite,MemRead,MemWrite,Branch,jump;

    control C(instruction[6:0],ALUSrc,MemtoReg,RegWrite, MemRead, MemWrite, Branch,Aluop);
    registerFile R(writeData,regWrite,instruction[19:15],instruction[24:20],clk,read1,read2,writeAd);
    immediateGenerator I(instruction,immediateOut);


    assign PC = pc;
    assign control = {ALUSrc,MemtoReg,Regwrite,MemRead,MemWrite,Branch,Aluop};
    assign readData1 = read1;
    assign readData2 = read2;
    assign immediate = immediateOut;
    assign ALUcontrol = {instruction[30],instruction[14:12]};
    assign rd = instruction[11:7];
    assign R1 = instruction[19:15];
    assign R2 = instruction[24:20];


endmodule