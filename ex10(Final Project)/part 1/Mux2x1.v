
module Mux2x1(in1, in2, select, out);
input in1, in2, select ;
output reg out ;

always @(in1, in2, select) 
begin 
 if(select) 
 out = in1;
 else 
 out = in2; 
end
endmodule
