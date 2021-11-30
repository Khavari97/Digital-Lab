module d_flip_flop( D , clock , Q , QB );
input D, clock;
output Q, QB;
reg Q, QB;
initial

begin
	Q=1'b0;
	QB=1'b1;
end

always @ (posedge clock)
	begin
		Q=D;
		QB=~Q;
	end

endmodule