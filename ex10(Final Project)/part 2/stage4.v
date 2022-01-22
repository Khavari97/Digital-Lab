
module stage4 (clk,adderResult, ALUResult, ReadData2,zero,controlSignal, rd0,
AdderResult, readData, Aluresult ,sel,controlsignal0,rd );

parameter Width = 32;    

input zero, clk;
input [Width-1:0] ALUResult, adderResult, ReadData2;
input [4:0] rd0;
input [5:0] controlSignal;


output [Width-1:0] AdderResult, readData, Aluresult;
output sel;
output [2:0] controlsignal0;
output [4:0] rd;

wire andoutput;
wire [Width-1:0]dataMemOut;

dataMemory DM (ALUResult,ReadData2,controlSignal[2],controlSignal[3],clk,dataMemOut);
and A(andoutput,zero,controlSignal[1]);

assign AdderResult = adderResult;
assign sel = andoutput;
assign rd = rd0;
assign readData = dataMemOut;
assign Aluresult = ALUResult;
assign controlsignal0 = {controlSignal[5:4],controlSignal[0]};

endmodule