module shift_register_tb;

wire Q0,Q1,Q2,Q3;
reg clock;
reg [0:3] IN;
shift_register memory(IN,clock,Q0,Q1,Q2,Q3);
initial
begin
	$monitor("%b, %b, %b, %b",IN,Q0,Q1,Q2,Q3);
	clock = 1'b1;
	IN = 4'b1101;
	#10
	clock=1'b0;
	IN = 4'b1001;
	clock = 1'b0;
end

endmodule
