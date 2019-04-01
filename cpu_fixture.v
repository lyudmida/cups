`include "adder.v"
`include "muxpc.v"
`include "pc.v"
`include "instrMem.v"
`include "ifid.v"

`include "hazard.v"
`include "cu.v"
`include "regFile.v"
`include "comparator.v"
`include "moduleB.v"
`include "shift.v"
`include "idex.v"

`include "mux5to1.v"
`include "alu.v"
`include "aluCU.v"
`include "forward.v"
`include "exmem.v"

`include "dataMem.v"

`include "memwb.v"

`include "mux2to1.v"


`include "cpu.v"

module cpu_fixture;

reg clk, reset;

wire [15:0] PCOUT, INSTRUCTION, IFADDER, IFIDINSTR;


wire [15:0] RD1, RD2;
wire [3:0] RR1, RR2;
wire [15:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15;

wire [15:0] IDEXRD1, IDEXRD2, IDEXSZOUT;

wire [15:0] MUXC, MUXD, ALUOUT, ALUR15;

wire [15:0] EXMEMALU, EXMEMRD1;

wire [15:0] RD;
wire [15:0] M0, M1, M2, M3, M4;

wire [15:0] MEMWBRD, MEMWBALUOUT, MEMWBRD1, MUXF, MEMWBRD15, MUXE;



cpu hellodrarad (.clk(clk), .reset(reset), .PCOUT(PCOUT), .INSTRUCTION(INSTRUCTION),

		.IFADDER(IFADDER), .IFIDINSTR(IFIDINSTR),

		.RD1(RD1), .RD2(RD2), .RR1(RR1), .RR2(RR2),
		.R0(R0), .R1(R1), .R2(R2), .R3(R3), .R4(R4), .R5(R5), .R6(R6), .R7(R7), .R8(R8), .R9(R9), .R10(R10), .R11(R11), .R12(R12), .R13(R13), .R14(R14), .R15(R15),

		.IDEXRD1(IDEXRD1), .IDEXRD2(IDEXRD2), .IDEXSZOUT(IDEXSZOUT),

		.MUXC(MUXC), .MUXD(MUXD), .ALUOUT(ALUOUT), .ALUR15(ALUR15),

		.EXMEMALU(EXMEMALU), .EXMEMRD1(EXMEMRD1), .RD(RD), .M0(M0), .M1(M1), .M2(M2), .M3(M3), .M4(M4),

		.MEMWBRD(MEMWBRD), .MEMWBALUOUT(MEMWBALUOUT), .MEMWBRD1(MEMWBRD1), .MUXF(MUXF), .MEMWBRD15(MEMWBRD15), .MUXE(MUXE));


initial
	$vcdpluson;

initial
begin
	$display("TIME C R PC ADDR  IM  B1IN|RR1  RR2   R0   R1   R2   R3   R4   R5   R6   R7   R8   R9  R10  R11  R12  R13  R14  R15  RD1  RD2  B2R1 B2R2 B2SZ|MUXD MUXC ALU  AL15 B3AL B3RD| RD   M0   M1   M2   M3   M4  MUXE|B4RD B4AL B4R1 B4MF B415");
	$monitor("%3d  %b %b %h %h %h %h|%b %b %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h %h|%h %h %h %h %h %h|%h %h %h %h %h %h %h|%h %h %h %h %h",


		$time, clk, reset,
		PCOUT[7:0], IFADDER, INSTRUCTION, IFIDINSTR,

		RR1, RR2, R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, RD1, RD2,

		IDEXRD1, IDEXRD2, IDEXSZOUT,

		MUXD, MUXC, ALUOUT, ALUR15, EXMEMALU, EXMEMRD1, RD, M0, M1, M2, M3, M4, MUXE,

		MEMWBRD, MEMWBALUOUT, MEMWBRD1, MUXF, MEMWBRD15);
	
end

initial
begin
	clk = 1'b0; reset = 1'b0;

	#5 reset = 1'b1;
end

initial
begin
	forever #10 clk = ~clk;
end

initial
begin
	#700;
	$display("\n\nNote on Display: Clk, Reset, (1st Stage) PC, Address, Instruction Memory");
	$display("\t\t\t (2nd Stage) Read Registers 1 & 2, Registers 0 through 15, Read Datas");
	$display("\t\t\t (3rd Stage) Multiplexors' outputs, ALU out");
	$display("\t\t\t (4th Stage) Memory Read Data, Memory Address Contents, Write Data");
	$display("\t\t\t (5th Stage) Write back, which is wired to the data read of stage 2");
	$display("\tBuffers: B1(buffer1)=IF/ID, B2=ID/EX, B3=EX/M, B4=M/WB\n");
	$finish;
end

endmodule
