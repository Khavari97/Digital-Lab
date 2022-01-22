
module stage3 (readData1,readData2,PC,immediate,rd,ALUcontrol,control,R1,R2,
zero,ALUResult, adderResult, ReadData2, rd0 ,controlSignal);

  parameter Width = 32;
  input [Width-1:0] readData1,readData2,PC;
  input [63:0] immediate;
  input [4:0] rd;
  input [3:0] ALUcontrol;
  input [7:0] control; 
  input [4:0] R1,R2;

  output zero;
  output [Width-1:0] ALUResult, adderResult, ReadData2;
  output [4:0] rd0;
  output [5:0] controlSignal;

  wire [Width-1:0] immediateout,ALUinput1,muxOut,ALUinput2,AdderResult,ALUresult;
  wire Zero;
  wire [3:0] ALUcontrolOut;
  

  multiplexer #(Width)M(readData2,immediate[Width-1:0],control[7],muxOut);
  adder A(PC,immediateout,AdderResult);
  ALUControl AC(control[1:0],ALUcontrol[3],ALUcontrol[2:0],ALUcontrolOut);
  ALU AL(readData1,muxOut,ALUcontrolOut,ALUresult,Zero);
  
  assign adderResult = AdderResult;
  assign ALUResult = ALUresult;
  assign zero = Zero;
  assign rd0 = rd;
  assign ReadData2 = readData2;
  assign controlSignal = control[7:2];
    
endmodule