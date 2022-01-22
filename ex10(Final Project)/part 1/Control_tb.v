
module Control_tb;

reg [6:0] opcode;
wire ALUSrc,MemtoReg,RegWrite, MemRead, MemWrite, Branch;
wire [1:0] Aluop;
control mycntrl (.opcode(opcode),.ALUSrc(ALUSrc),.MemtoReg(MemtoReg),.RegWrite(RegWrite),
 .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch),.Aluop(Aluop));

 initial begin
   $dumpfile("control_tb.vcd");
   $dumpvars(0,control_tb);

  opcode = 7'b0;

  #100;
  $stop();
  
  end
 
 initial begin
    $display("test completed");
 end

endmodule