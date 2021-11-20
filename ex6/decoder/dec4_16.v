module Decoder4x16(w,en,y);
input [3:0]w;
input en;
output reg [0:15]y;
integer k;
always @(w,en)
  for(k=0;k<=15;k=k+1)
    if((w == k)&&(en == 1))
      y[k]=1;
    else
      y[k]=0;
endmodule