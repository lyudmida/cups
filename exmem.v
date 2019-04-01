//EX/MEM Buffer

module exmem (input clk, reset,
	      input [15:0] ALUout, rd1, rd15,
	      input [3:0] op1, op2,
	      input [2:0] regWrite,
	      input w, r, sb, F,

	      output reg [15:0] exmemALUout, exmemRD1, exmemRD15,
	      output reg [3:0] exmemOP1, exmemOP2,
	      output reg [2:0] exmemregWrite,
	      output reg exmemW, exmemR, exmemSB, exmemF);

reg [15:0] tempALUout, tempRD1, tempRD15;
reg [3:0] tempOP1, tempOP2;
reg [2:0] tempregWrite;
reg tempW, tempR, tempSB, tempF;

always@(posedge clk or negedge reset)
begin
	if(!reset)
	begin
		//Memory
		tempW <= 1'b0;
		tempR <= 1'b0;
		tempSB <= 1'b0;

		//Write Back
		tempF <= 1'b0;


		tempALUout <= 16'h0000;
		tempRD1 <= 16'h0000;
		tempRD15 <= 16'h0000;
		tempOP1 <= 4'b0000;
		tempOP2 <= 4'b0000;
		tempregWrite <= 3'b000;
	end

	else
	begin
		//Memory
		tempW <= w;
		tempR <= r;
		tempSB <= sb;

		//Write Back
		tempF <= F;


		tempALUout <= ALUout;
		tempRD1 <= rd1;
		tempRD15 <= rd15;
		tempOP1 <= op1;
		tempOP2 <= op2;
		tempregWrite <= regWrite;
	end
end

always@(*)
begin
	exmemALUout = tempALUout;
	exmemRD1 = tempRD1;
	exmemRD15 = tempRD15;
	exmemOP1 = tempOP1;
	exmemOP2 = tempOP2;
	exmemW = tempW;
	exmemR = tempR;
	exmemSB = tempSB;
	exmemF = tempF;
	exmemregWrite = tempregWrite;
end

endmodule
