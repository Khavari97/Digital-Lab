
module fulladder1bit(x,y,cin,sum,cout); 
input x , y , cin;
output sum,cout  ;

assign cout = (x&&y) || (x&&cin) || (cin&&y) ;
assign sum = x ^ y ^ cin ;

endmodule

module fulladder2bit(x,y,cin,sum,cout);
input [0:1] x ;
input [0:1] y ;
input cin ;
output [0:1] sum ;
output cout;
wire [0:1] carryouts ;

fulladder1bit f1(x[0],y[0],cin,sum[0],carryouts[0]);
fulladder1bit f2(x[1],y[1],carryouts[0],sum[1],cout);

endmodule

module fulladder4bit(x,y,cin,sum,cout);
input [0:3] x ;
input [0:3] y ;
input cin ;
output [0:3] sum ;
output cout;
wire [0:1] carryouts ;

fulladder2bit f1(x[0:1],y[0:1],cin,sum[0:1],carryouts[0]);
fulladder2bit f2(x[2:3],y[2:3],carryouts[0],sum[2:3],cout);

endmodule

module fulladder16bit(x,y,cin,sum,cout);
input [0:15] x ;
input [0:15] y ;
input cin ;
output [0:15] sum ;
output cout;
wire [0:2] middle_carry ;

fulladder4bit f1(x[0:3],y[0:3],cin,sum[0:3],middle_carry[0]);
fulladder4bit f2(x[4:7],y[4:7],middle_carry[0],sum[4:7],middle_carry[1]);
fulladder4bit f3(x[8:11],y[8:11],middle_carry[1],sum[8:11],middle_carry[2]);
fulladder4bit f4(x[12:15],y[12:15],middle_carry[2],sum[12:15],cout);
endmodule



module fulladder64bit(x,y,cin,sum,cout);
input [0:63] x ;
input [0:63] y ;
input cin ;
output [0:63] sum ;
output cout;
wire [0:2] middle_carry ;

fulladder16bit f1(x[0:15],y[0:15],cin,sum[0:15],middle_carry[0]);
fulladder16bit f2(x[16:31],y[16:31],middle_carry[0],sum[16:31],middle_carry[1]);
fulladder16bit f3(x[32:47],y[32:47],middle_carry[1],sum[32:47],middle_carry[2]);
fulladder16bit f4(x[48:63],y[48:63],middle_carry[2],sum[48:63],cout);
endmodule




