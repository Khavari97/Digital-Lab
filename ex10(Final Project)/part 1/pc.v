module DFF(D,Q,clk);
input D,clk ;
output reg Q ;
always @(posedge clk)
Q = D ;
endmodule

module shiftReg(inp ,Q , L , clk , Load);
input [0:3] L ; 
input clk , Load , inp ;
output wire [0:3] Q ;
reg [0:3] d ; 
integer j ;

generate
genvar i ;

for(i=0;i<4 ;i=i+1) 
begin
DFF stage(.D(d[i]),.Q(Q[i]),.clk(clk)) ;

end

endgenerate

always @(posedge clk)
begin 

for(j=1;j<4 ;j=j+1) 
begin

if(!Load)
begin
d[j] <= d[j-1] ;
d[0]= inp ;
end

else
begin
d[0] <= L[0] ;
d[j] <= L[j];
end

end


end

endmodule
