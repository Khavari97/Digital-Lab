
module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, ReadData1, ReadData2, WriteData, RegWrite, reset, clk);

input [4:0] ReadRegister1, ReadRegister2, WriteRegister; // Register numbers
input [63:0] WriteData; // Data to be written 
input RegWrite, reset, clk ; // Other signals
output wire [63:0] ReadData1,ReadData2 ; // Always outputs readed data 
reg [63:0]  regFile [31:0]; // 32 Register 64-bit storages
integer i; 

// Always happens without any condition
assign ReadData1 = regFile[ReadRegister1];
assign ReadData2 = regFile[ReadRegister2];

always@(posedge clk)
begin

//Register file reset
if(reset) 
begin
for (i = 0; i < 32; i = i + 1) begin
    regFile [i] = 64'h0; 

   end 
end

else if (RegWrite)
begin
regFile[WriteRegister] <=  WriteData ;
end

end

endmodule
