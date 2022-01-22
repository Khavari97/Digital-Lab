
module stage5(readData,ALUResult,controlsignals,Rd,RegWrite,Writeback,rd);
parameter Width=32;
// control signals -> regwrite and memtoreg

input [Width-1:0] readData,ALUResult;
input [2:0] controlsignals;
input [4:0] Rd;
output RegWrite;
output [Width-1:0] Writeback; 
output [4:0] rd;

wire [Width-1:0] writeback;
multiplexer #(Width)M(ALUResult,readData,controlsignals[2],writeback);

assign Writeback = writeback;
assign RegWrite = controlsignals[1];
assign rd = Rd;
endmodule