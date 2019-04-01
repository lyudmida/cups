`include "regFile.v"

module regFile_fixture;

reg clk, reset;
reg [2:0] regWrite;
reg [3:0] rr1, rr2, wr, wr2;	/*rr = Read Reg, wr = Write Reg*/
reg [15:0] wd, wd2, wd15;		/*wd = Write Data*/	

wire [15:0] rd1, rd2, rd15;
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;

regFile rf (.clk(clk), .reset(reset), .regWrite(regWrite), .rr1(rr1), .rr2(rr2),
		.wr(wr), .wr2(wr2), .wd(wd), .wd2(wd2), .wd15(wd15),
		.rd1(rd1), .rd2(rd2), .rd15(rd15),
		.r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15));

initial
	$vcdpluson;

initial
begin
	$display("\t\tTIME CLK RESET\t R0   R1   R2   R3   R5   R6   R7   R8   R9   R10  R11  R12  R13  R14  R15  RW\tWR\tWR2\tWD\tWD2\tWRD15");
	$monitor("%d  %b    %b\t%h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h\t%h\t%h\t%h\t%h\t%h",
		$time, clk, reset, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, regWrite, wr, wr2, wd, wd2, wd15);
end

initial
begin
	clk = 1'b0; reset = 1'b0;

	#5 reset = 1'b1; regWrite = 3'b001; wr = 4'b0001; wd = 16'hAAAA;
	#5 regWrite = 3'b010; wr2 = 4'b0010; wd2 = 16'hAAAA;
	#5 regWrite = 3'b101; wr2 = 4'b0010; wd2 = 16'hABCD;
end

initial
begin
	forever #10 clk = ~clk;
end

initial
begin
	#20 $finish;
end

endmodule
