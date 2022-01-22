
module Data_Memory(clk, we, address, wd, readData);
   input clk;
   input we;
   input[5:0] address;
   input[31:0] wd;
   output[31:0] readData;
   reg [31:0] ram[0:63];
   assign readData = ram[address[5:2]];
   always @(posedge clk)
   if (we) ram[address[5:2]] <= wd;
endmodule