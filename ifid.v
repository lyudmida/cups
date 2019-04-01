//IF/ID Buffer

module ifid (input clk, reset, stall,
	     input [15:0] instruction, pc,
	     output reg [15:0] ifidPC, ifidInstr);

reg [15:0] tempPC, tempInstr;

always@(posedge clk or negedge reset)
begin
	if(!reset)
	begin
		tempPC <= 16'h0000;
		tempInstr <= 16'h0000;
	end

	else if(stall)
	begin
		tempPC <= tempPC;
		tempInstr <= tempInstr;
	end

	else
	begin
		tempPC <= pc;
		tempInstr <= instruction;
	end
end

always@(*)
begin
	ifidPC = tempPC;
	ifidInstr = tempInstr;
end

endmodule
