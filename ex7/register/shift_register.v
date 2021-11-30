
  module shift_register(IN, clock, Q0, Q1, Q2, Q3);
	input [0:3] IN;
	input clock;
	output wire Q0, Q1, Q2, Q3;
	reg D0, D1, D2, D3;
	wire qb0, qb1, qb2, qb3;
	
	d_flip_flop ins0(D0, clock, Q0, qb0);
	d_flip_flop ins1(D1, clock, Q1, qb1);
	d_flip_flop ins2(D2, clock, Q2, qb2);
	d_flip_flop ins3(D3, clock, Q3, qb3);

	always @ (posedge clock)
		if (clock)
			begin
				D0 = IN[0];
				D1 = IN[1];
				D2 = IN[2];
				D3 = IN[3];
			end

  endmodule