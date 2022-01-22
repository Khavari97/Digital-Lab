
module Data_Memory_tb;
   reg reset_; initial begin reset_=0; #22 reset_=1; #600; $stop; end
   reg clk;  initial clk<=0;   always #5 clk<=(!clk);
   reg [5:0] memAddressRef;
   reg we;
   reg [31:0] wd;
   wire [31:0] rd;
   initial begin
      wait(reset_==1); memAddressRef<=32'hXXXXXXXX; we<=0;
      @(posedge clk); memAddressRef<=0;  @(posedge clk); memAddressRef<=4;  @(posedge clk); memAddressRef<=8;  @(posedge clk); memAddressRef<=12;
      @(posedge clk); memAddressRef<=16; @(posedge clk); memAddressRef<=20; @(posedge clk); memAddressRef<=24; @(posedge clk); memAddressRef<=28;
      @(posedge clk); memAddressRef<=32; @(posedge clk); memAddressRef<=36; @(posedge clk); memAddressRef<=40; @(posedge clk); memAddressRef<=44;
      @(posedge clk); memAddressRef<=48; @(posedge clk); memAddressRef<=52; @(posedge clk); memAddressRef<=56; @(posedge clk); memAddressRef<=60;
      #10 we <=1; wd=32'h12345678;
      @(posedge clk); memAddressRef<=0;  wd<=1;  @(posedge clk); memAddressRef<=4;  wd<=2;  @(posedge clk); memAddressRef<=8;  wd<=3;  @(posedge clk); memAddressRef<=12; wd<=4;
      @(posedge clk); memAddressRef<=16; wd<=5;  @(posedge clk); memAddressRef<=20; wd<=6;  @(posedge clk); memAddressRef<=24; wd<=7;  @(posedge clk); memAddressRef<=28; wd<=8;
      @(posedge clk); memAddressRef<=32; wd<=9;  @(posedge clk); memAddressRef<=36; wd<=10; @(posedge clk); memAddressRef<=40; wd<=11; @(posedge clk); memAddressRef<=44; wd<=12;
      @(posedge clk); memAddressRef<=48; wd<=13; @(posedge clk); memAddressRef<=52; wd<=14; @(posedge clk); memAddressRef<=56; wd<=15; @(posedge clk); memAddressRef<=60; wd<=16;
      #10 memAddressRef<=32'hXXXXXXXX; we<=0; #10
      @(posedge clk); memAddressRef<=0;  @(posedge clk); memAddressRef<=4;  @(posedge clk); memAddressRef<=8;  @(posedge clk); memAddressRef<=12;
      @(posedge clk); memAddressRef<=16; @(posedge clk); memAddressRef<=20; @(posedge clk); memAddressRef<=24; @(posedge clk); memAddressRef<=28;
      @(posedge clk); memAddressRef<=32; @(posedge clk); memAddressRef<=36; @(posedge clk); memAddressRef<=40; @(posedge clk); memAddressRef<=44;
      @(posedge clk); memAddressRef<=48; @(posedge clk); memAddressRef<=52; @(posedge clk); memAddressRef<=56; @(posedge clk); memAddressRef<=60;
      #10 $finish;
   end
   dataMemory DMEM(clk,we,memAddressRef,wd,rd);
endmodule