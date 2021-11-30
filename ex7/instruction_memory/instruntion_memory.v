module instruction_memory(Address, Instruction); 

    input       [31:0]  Address;        

    output   [31:0]  Instruction;    
    
    reg [31:0] mem[0:1024];


	initial
	begin
		$readmemh("code.txt",mem);
	end

	assign Instruction = mem[Address>>2];	
	

endmodule