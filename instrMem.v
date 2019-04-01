//Instruction Memory

module instrMem (input clk, reset,
		 input [15:0] pcout,
		 output reg [15:0] instruction);

reg [15:0] instrAdd [54:0]; //Instruction Address

always@(posedge clk or negedge reset)
begin
	if(!reset)
	begin
		instrAdd[00] <= 16'b1111000100100000; //ADD R1, R2	F120
		instrAdd[02] <= 16'b1111000100100001; //SUB R1, R2	F121
		instrAdd[04] <= 16'b1001001111111111; //ORi R3, FF	93FF
		instrAdd[06] <= 16'b1000001101001100; //ANDi R3,4C	824C
		instrAdd[08] <= 16'b1111010101100100; //MUL R5, R6	F564
		instrAdd[10] <= 16'b1111000101010101; //DIV R1, R5	F155
		instrAdd[12] <= 16'b1111111111110001; //SUB R15, R15	FFF1
		instrAdd[14] <= 16'b1111010010000111; //MOV R4, R8	F487
		instrAdd[16] <= 16'b1111010001101000; //SWP R4, R6	F468
		instrAdd[18] <= 16'b1001010000000010; //ORi R4, 2	9402
		instrAdd[20] <= 16'b1010011010010100; //LBU R6, 4(R9)	A694
		instrAdd[22] <= 16'b1011011010010110; //SB R6, 6(R9)	B696
		instrAdd[24] <= 16'b1100011010010110; //LW R6, 6(R9)	C696
		instrAdd[26] <= 16'b0110011100000100; //BEQ R7, 4	6704
		instrAdd[28] <= 16'b1111101100010000; //ADD R11, R1	FB10
		instrAdd[30] <= 16'b0101011100000101; //BLT R7, 5	5705
		instrAdd[32] <= 16'b1111101100100000; //ADD R11, R2	FB20
		instrAdd[34] <= 16'b0100011100000010; //BGT R7, 2	4702
		instrAdd[36] <= 16'b1111000100010000; //ADD R1, R1	F110
		instrAdd[38] <= 16'b1111000100010000; //ADD R1, R1	F110
		instrAdd[40] <= 16'b1100100010010000; //LW R8, 0(R9)	C890
		instrAdd[42] <= 16'b1111100010000000; //ADD R8, R8	F880
		instrAdd[44] <= 16'b1101100010010010; //SW R8, 2(R9)	D892
		instrAdd[46] <= 16'b1100101010010010; //LW R10, 2(R9)	CA92
		instrAdd[48] <= 16'b1111110011000000; //ADD R12, R12	FCC0
		instrAdd[50] <= 16'b1111110111010001; //SUB R13, R13	FDD1
		instrAdd[52] <= 16'b1111110011010000; //ADD R12, R13	FCD0
		instrAdd[54] <= 16'h0; 	//EFFF


	end
end

always@(*)
begin
	instruction = instrAdd[pcout];
end

endmodule
