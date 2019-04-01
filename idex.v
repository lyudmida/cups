//ID/EX Buffer

module idex (input clk, reset, stall,
	     input [15:0] rd1, rd2, szout,
	     input [3:0] op1, op2, fc,
	     input [2:0] C, D, regWrite,
	     input [1:0] aoi,
	     input w, r, sb, F, G,
	     output reg [15:0] idexRD1, idexRD2, idexSZOUT,
	     output reg [3:0] idexOP1, idexOP2, idexFC,
	     output reg [2:0] idexC, idexD, idexregWrite,
	     output reg [1:0] idexAOI,
	     output reg idexW, idexR, idexSB, idexF, idexG);

reg [15:0] tempRD1, tempRD2, tempSZOUT;
reg [3:0] tempOP1, tempOP2, tempFC;
reg [2:0] tempC, tempD, tempregWrite;
reg [1:0] tempAOI;
reg tempW, tempR, tempSB, tempF, tempG;

always@(posedge clk or negedge reset)
begin
	if(!reset)
	begin
		//Execution
		tempFC <= 4'b0000;
		tempC <= 3'b000;
		tempD <= 3'b000;
		tempAOI <= 2'b00;

		//Memory
		tempW <= 1'b0;
		tempR <= 1'b0;
		tempSB <= 1'b0;

		//Write Back
		tempF <= 1'b0;
		tempG <= 1'b0;


		tempRD1 <= 16'h0000;
		tempRD2 <= 16'h0000;
		tempSZOUT <= 16'h0000;

		tempOP1 <= 4'b0000;
		tempOP2 <= 4'b0000;

		tempregWrite <= 3'b000;
	end

	else if (stall)
	begin
		//Execution
		tempFC <= 4'b0000;
		tempC <= 3'b000;
		tempD <= 3'b000;
		tempAOI <= 2'b00;

		//Memory
		tempW <= 1'b0;
		tempR <= 1'b0;
		tempSB <= 1'b0;

		//Write Back
		tempF <= 1'b0;
		tempG <= 1'b0;


		tempRD1 <= 16'h0000;
		tempRD2 <= 16'h0000;
		tempSZOUT <= 16'h0000;

		tempOP1 <= 4'b0000;
		tempOP2 <= 4'b0000;

		tempregWrite <= 3'b000;
	end

	else
	begin
		//Execution
		tempFC <= fc;
		tempC <= C;
		tempD <= D;
		tempAOI <= aoi;

		//Memory
		tempW <= w;
		tempR <= r;
		tempSB <= sb;

		//Write Back
		tempF <= F;
		tempG <= tempG;


		tempRD1 <= rd1;
		tempRD2 <= rd2;
		tempSZOUT <= szout;

		tempOP1 <= op1;
		tempOP2 <= op2;

		tempregWrite <= regWrite;
	end
end

always@(*)
begin
	//EX
	idexFC = tempFC;
	idexC = tempC;
	idexD = tempD;
	idexAOI = tempAOI;

	//MEM
	idexW = tempW;
	idexR = tempR;
	idexSB = tempSB;

	//WB
	idexF = tempF;
	idexG = tempG;


	idexRD1 = tempRD1;
	idexRD2 = tempRD2;
	idexSZOUT = tempSZOUT;

	idexOP1 = tempOP1;
	idexOP2 = tempOP2;

	idexregWrite = tempregWrite;	
end

endmodule
