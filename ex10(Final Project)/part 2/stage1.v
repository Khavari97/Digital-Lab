module stage1 (clk,PCSrc,pc_enable,pcAddFour,adderResult,addressOut,instruction);
parameter Width = 32;

input [Width-1 : 0]adderResult,pcAddFour;
input pc_enable,PCSrc,clk;
output [Width-1 : 0]addressOut,instruction;

wire [Width-1:0] pc_input,pcOut,insRead;
multiplexer #(Width)M(adderResult,pcAddFour,PCSrc,pc_input);
programCounter PC(pc_enable,pc_input,clk,pcOut);
addFour A(pcOut,pcAddFour);
insMem I(pcOut,insRead);

assign addressOut = pcOut;
assign instruction = insRead;
    
endmodule