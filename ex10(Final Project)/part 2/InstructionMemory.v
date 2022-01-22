
module InstructionMemory( ReadAddress ,transferData ); // half kilobyte ram , 8-bit words
wire [4095:0] storeddData ;
reg [63:0] memory [63:0] ; 
input [5:0] ReadAddress; 
output wire [63:0] transferData ;
integer i ; 

MemoryDataFiller MDF( storeddData );

always @* 
begin
for(i=0;i<63;i=i+1)
memory[i] = storeddData[i*64 +: 64] ;

end

assign transferData = memory[ReadAddress]; 

endmodule


module MemoryDataFiller(data);
output reg [4095:0] data ;
integer i ;

initial 
begin
for(i=0;i<63;i=i+1)
data[i*64 +: 64] <= {{58{1'b0}},i[5:0]}; // fills memory with numbers 0 to 63 in length and format of 64-bit 
end

endmodule  
