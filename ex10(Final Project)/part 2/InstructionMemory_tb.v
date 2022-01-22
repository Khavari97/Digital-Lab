
module InstructionMemory_tb;

parameter Width = 32;
reg  [Width-1:0]adress;
wire  [Width-1:0]readData;

insMem ins (.adress(adress),.readData(readData));

 initial begin
   $dumpfile("insMem_tb.vcd");
   $dumpvars(0,insMem_tb);

  adress = 32'b0;
  
  #100;
  $stop();
  
  end
 
 initial begin
    $display("test completed");
 end

endmodule