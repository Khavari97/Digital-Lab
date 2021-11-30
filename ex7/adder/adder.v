module full_adder_n (c_in, x,y,s,c_out,overflow);
	input c_in;
	input [63:0]x,y;
	output reg [63:0]s;
	output reg c_out,overflow;
	reg [64:0]Sum;

	always @(x,y,c_in)
	begin
		Sum={1'b0,x}+{1'b0,y}+c_in;
		s=Sum[63:0];
		c_out=Sum[64];
		overflow=(x[63]&y[63]&~s[63])|(~x[63]&~y[63&s[63]]);
	end
endmodule

