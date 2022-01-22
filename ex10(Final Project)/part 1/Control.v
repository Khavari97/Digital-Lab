
module Control(inputSignal, ALUSrc, MemtoReg, RegWrite,
		MemRead, MemWrite, Branch, ALUOp1, ALUOp0) ;  

input [6:0] inputSignal ;
output wire ALUSrc, MemtoReg, RegWrite,
       MemRead, MemWrite, Branch, ALUOp1, ALUOp0 ;

reg [7:0] out ;
assign ALUSrc = out[7], MemtoReg = out[6], RegWrite = out[5], 
        MemRead = out[4], MemWrite = out[3], Branch = out[2],
	 ALUOp1 = out[1], ALUOp0 = out[0];


always@(inputSignal)
begin
case(inputSignal)
	7'b0110011 : out = 8'b00100010 ;
	7'b0000011 : out = 8'b11110000 ;
	7'b0100011 : out = 8'b1x001000 ;
	7'b1100011 : out = 8'b0x000101 ;
	default : out = 8'b00000011;
endcase	


end
endmodule