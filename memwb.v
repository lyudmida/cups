//MEM/WB Buffer

module memwb (input clk, reset, of,
	      input [15:0] rd, ALUout, rd1, rd15,
	      input [3:0] op1, op2,
	      input [2:0] regWrite,
	      input F,

	      output reg [15:0] memwbRD, memwbALUout, memwbRD1, memwbRD15,
	      output reg [3:0] memwbOP1, memwbOP2,
	      output reg [2:0] memwbregWrite,
	      output reg memwbF);


reg [15:0] tempRD, tempALUout, tempRD1, tempRD15;
reg [3:0] tempOP1, tempOP2;
reg [2:0] tempregWrite;
reg tempF;

always@(posedge clk or negedge reset)
begin
	if(!reset || of)
	begin
		//Write Back		
		tempF <= 1'b0;

		tempRD <= 16'h0000;
		tempALUout <= 16'h0000;
		tempRD1 <= 16'h0000;
		tempRD15 <= 16'h0000;

		tempOP1 <= 4'b0000;
		tempOP2 <= 4'b0000;

		tempregWrite <= 3'b000;
	end

	else
	begin
		tempF <= F;

		tempRD <= rd;
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
	memwbRD = tempRD;
	memwbALUout = tempALUout;
	memwbRD1 = tempRD1;
	memwbRD15 = tempRD15;
	memwbOP1 = tempOP1;
	memwbOP2 = tempOP2;
	memwbF = tempF;
	memwbregWrite = tempregWrite;
end

endmodule
