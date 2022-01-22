
module ALU (Op1, Op2, select, out, Zero);
input [63:0] Op1, Op2;
input[3:0] select;
output [63:0] out ;
output reg Zero;
reg [63:0] result;

assign out = result; 
always@(Op1, Op2, select)
begin

if(Op1==Op2)
Zero <= 1 ;

case(select)


	//   and 
          4'b0000: 
           result = Op1 & Op2;

	//   or
          4'b0001: 
           result = Op1 | Op2;

	// Addition
 	4'b0010: 
           result = Op1 + Op2 ; 

	// Subtraction
        4'b0011: 
           result = Op1 - Op2 ;

	// Multiplication
        4'b0100: 
           result = Op1 * Op2;

	// Division
        4'b0101: 
           result = Op1/Op2;

	// Logical shift left
        4'b0110: 
           result = Op1<<1;

	// Logical shift right
         4'b0111: 
           result = Op1>>1;

	// Rotate left
         4'b1000: 
           result = {Op1[6:0],Op1[7]};

	// Rotate right
         4'b1001: 
           result = {Op1[0],Op1[7:1]};


	//   nor
          4'b1010: 
           result = ~(Op1 | Op2);

	//  nand 
          4'b1011: 
           result = ~(Op1 & Op2);

	//   xor 
          4'b1100: 
           result = Op1 ^ Op2;

	//  xnor
          4'b1101: 
           result = ~(Op1 ^ Op2);

endcase
end

endmodule

