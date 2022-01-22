module ALU_tb();
reg [63:0] Op1,Op2;
reg [3:0] select ;
wire [63:0] out ;
wire carry_out ;
integer i;
ALU alu(.Op1(Op1), .Op2(Op2), .select(select), .out(out), .carry_out(carry_out));

initial begin
    // hold reset state for 100 ns.
      Op1 = 4'h071A;
      Op2 = 4'h1230;
      select = 4'b0000;
      
      for (i=0;i<=15;i=i+1)
      begin
       select = i ;
       #10;
      end
      
    end

endmodule
