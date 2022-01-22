`timescale 1 ns /1 ns
module ALU_control_tb();

reg[2:0] cnrl;
reg[5:0] funct;
wire[3:0]out;

ALU_control UUT (funct, cnrl, out);

initial begin

#10 $write("\n");
	cnrl=3'b000;
	funct=6'bxxxxxx;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	cnrl=3'b010;
	funct=6'b001000;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	cnrl=3'b100;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	cnrl=3'b010;
	funct=6'b001001;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	cnrl=3'b101;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	cnrl=3'b010;
	funct=6'b100000;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	cnrl=3'b110;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	cnrl=3'b010;
	funct=6'b100001;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	cnrl=3'b001;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	cnrl=3'b010;
	funct=6'b100100;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	cnrl=3'b011;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	cnrl=3'b010;
	funct=6'b100010;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	cnrl=3'b111;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	cnrl=3'b010;
	funct=6'b100011;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	funct=6'b100101;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	funct=6'b100110;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	funct=6'b100111;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	funct=6'b000000;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	funct=6'b000100;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	funct=6'b000010;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	funct=6'b000110;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	funct=6'b000011;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	funct=6'b000111;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	funct=6'b101001;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	funct=6'b101010;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	funct=6'b111111;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#10 $write("\n");
	funct=6'bxxxxxx;
	$strobe("%d UUT: cnrl = %b funct =%b out=%b", $time, cnrl, funct, out);

#20 $finish;
end
endmodule


