//Register File

module regFile (input clk, reset,
		input [2:0] regWrite,
		input [3:0] rr1, rr2, wr, wr2,	/*rr = Read Reg, wr = Write Reg*/
		input [15:0] wd, wd2, wd15,	/*wd = Write Data*/	
		output reg [15:0] rd1, rd2, rd15,/*rd = Read Data*/

		output reg [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15);

reg [15:0] register [15:0];

always @(posedge clk or negedge reset)
begin
	if (!reset)
	begin
		register[0]	<= 16'h0000;
		register[1]	<= 16'h0F00;
		register[2]	<= 16'h0050;
		register[3]	<= 16'hFF0F;
		register[4]	<= 16'hF0FF;
		register[5]	<= 16'h0040;
		register[6]	<= 16'h6666;
		register[7]	<= 16'h00FF;
		register[8]	<= 16'hFF88;
		register[9]	<= 16'h0000;
		register[10]	<= 16'h0000;
		register[11]	<= 16'h0000;
		register[12]	<= 16'hCCCC;
		register[13]	<= 16'h0002;
		register[14]	<= 16'h0000;
		register[15]	<= 16'h0000;
	end
	
	else
	begin
		if (regWrite == 3'b001)
			register[wr] <= wd;
		if (regWrite == 3'b010)
			register[wr2] <= wd2;
		if (regWrite == 3'b011)
		begin
			register[wr] <= wd;
			register[wr2] <= wd2;
		end
		if (regWrite == 3'b101)
		begin
			register[15] <= wd15;
			register[wr] <= wd;
		end

	end
end

always@(*)
begin
	rd1 = register[rr1];
	rd2 = register[rr2];
	rd15 = register[15];

	r0 = register[0];
	r1 = register[1];
	r2 = register[2];
	r3 = register[3];
	r4 = register[4];
	r5 = register[5];
	r6 = register[6];
	r7 = register[7];
	r8 = register[8];
	r9 = register[9];
	r10 = register[10];
	r11 = register[11];
	r12 = register[12];
	r13 = register[13];
	r14 = register[14];	
	r15 = register[15];
end

endmodule
