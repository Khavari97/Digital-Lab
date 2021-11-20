module Mux(Zero, One, Select, Out);
	parameter n=64;
	input [n-1:0] Zero, One;
	input Select;
	output [n-1:0] Out;

	assign Out = (Select == 0) ? Zero : One;

endmodule