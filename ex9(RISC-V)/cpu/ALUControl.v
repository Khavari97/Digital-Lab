
module ALUControl(ALUOp0, ALUOp1, function7, function3, ALUControl, clk) ;  

input ALUOp0, ALUOp1, clk ;
input [6:0] function7 ;
input [2:0] function3 ;
reg [4:0] out ;
output wire [4:0] ALUControl ;
assign ALUControl = out ;

always@(posedge clk)
begin
case({ALUOp1, ALUOp0,function7, function3})

	12'b00xxxxxxxxxx : // ld,sd
	 out = 4'b0010 ;

	12'bx1xxxxxxxxxx : // beq -> subtract to find equality 
	 out = 4'b0110 ;

	12'b1x0000000000 : // R-type -> add
	 out = 4'b0010 ;

	12'b1x0100000000 : // R-type -> subtract
	 out = 4'b0110 ;

	12'b1x0000000111 : // R-type -> and
	 out = 4'b0000 ;

	12'b1x0000000110 : // R-type -> or
	 out = 4'b0001 ;
	
	
endcase	


end
endmodule