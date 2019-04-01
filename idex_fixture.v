`include "idex.v"

module idex_fixture;

reg clk, reset, stall;
reg [15:0] rd1, rd2, szout;
reg [3:0] op1, op2, fc;
reg [2:0] C, D, regWrite;
reg [1:0] aoi;
reg w, r, sb, F, G;


wire [15:0] idexRD1, idexRD2, idexSZOUT;
wire [3:0] idexOP1, idexOP2, idexFC;
wire [2:0] idexC, idexD, idexregWrite;
wire [1:0] idexAOI;
wire idexW, idexR, idexSB, idexF, idexG;

idex idexi(.clk(clk), .reset(reset), .stall(stall),
		.rd1(rd1), .rd2(rd2), .szout(szout),
		.op1(op1), .op2(op2), .fc(fc),
		.C(C), .D(D), .regWrite(regWrite),
		.aoi(aoi),
		.w(w), .r(r), .sb(sb), .F(F),
		.idexRD1(idexRD1), .idexRD2(idexRD2), .idexSZOUT(idexSZOUT),
		.idexOP1(idexOP1), .idexOP2(idexOP2), .idexFC(idexFC),
		.idexC(idexC), .idexD(idexD), .idexregWrite(idexregWrite),
		.idexAOI(idexAOI),
		.idexW(idexW), .idexR(idexR), .idexSB(idexSB), .idexF(idexF), .idexG(idexG));

initial
	$vcdpluson;

initial
begin
	$display("TIME CLK RESET STALL  RD1 RD2\t SZOUT\t OP1\t OP2\t  FC\t  C   D   RW AOI W R SB F G");
	$monitor("%3d   %b    %b     %b   %h %h\t %h\t %b\t %b\t %b\t %b %b  %b %b %b %b  %b %b %b",
		$time, clk, reset, stall, idexRD1, idexRD2, idexSZOUT,
		idexOP1, idexOP2, idexFC, idexC, idexD, idexregWrite,
		idexAOI, idexW,	idexR, idexSB, idexF, idexG);
end

initial
begin
	clk = 1'b0; reset = 1'b0;
	#10 reset = 1'b1;

	#20
	stall = 1'b0;
	rd1 = 16'h0A0A; rd2 = 16'h1010; szout = 16'hA111;
	op1 = 4'b0001; op2 = 4'b1000; fc = 4'b0010;
	C = 3'b000; D = 3'b111; regWrite = 3'b001;
	aoi = 2'b01;
	w = 1'b1; r = 1'b0; sb = 1'b1; F = 1'b0; G = 1'b0;

	#20
	stall = 1'b1;
	rd1 = 16'h1F1F; rd2 = 16'hF0F0; szout = 16'h11F1;
	op1 = 4'b0101; op2 = 4'b1010; fc = 4'b1001;
	C = 3'b111; D = 3'b000; regWrite = 3'b000;
	aoi = 2'b10;
	w = 1'b0; r = 1'b1; sb = 1'b0; F = 1'b1; G = 1'b1;
end

initial
	forever #10 clk = ~clk;

initial
	#90 $finish;

endmodule
