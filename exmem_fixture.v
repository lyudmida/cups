`include "exmem.v"

module exmem_fixture;

reg clk, reset;
reg [15:0] ALUout, rd1, rd15;
reg [3:0] op1, op2;
reg [2:0] regWrite;
reg w, r, sb, F;

wire [15:0] exmemALUout, exmemRD1, exmemRD15;
wire [3:0] exmemOP1, exmemOP2;
wire [2:0] exmemregWrite;
wire exmemW, exmemR, exmemSB, exmemF;

exmem exmemi(.clk(clk), .reset(reset), .ALUout(ALUout), .rd1(rd1), .rd15(rd15),
		.op1(op1), .op2(op2), .regWrite(regWrite), .w(w), .r(r), .sb(sb), .F(F),
		.exmemALUout(exmemALUout), .exmemRD1(exmemRD1), .exmemRD15(exmemRD15),
		.exmemOP1(exmemOP1), .exmemOP2(exmemOP2),
		.exmemregWrite(exmemregWrite),
		.exmemW(exmemW), .exmemR(exmemR), .exmemSB(exmemSB), .exmemF(exmemF));

initial
	$vcdpluson;

initial
begin
	$display("TIME CLK RESET ALUout  RD1 RD15\t OP1\t OP2\t RW   W R SB F");
	$monitor("%3d   %b    %b    %h  %h %h\t %b\t %b\t %b  %b %b %b  %b",
		$time, clk, reset, exmemALUout, exmemRD1, exmemRD15,
		exmemOP1, exmemOP2, exmemregWrite, exmemW, exmemR, exmemSB, exmemF);
end

initial
begin
	clk = 1'b0; reset = 1'b0;
	#5 reset = 1'b1;

	ALUout = 16'hA0A0; 
	rd1 = 16'h0A0A; rd15 = 16'h0098;
	op1 = 4'b0001; op2 = 4'b0010;
	regWrite = 3'b010;
	w = 1'b1; r = 1'b0; sb = 1'b1; F = 1'b0;

	#20
	ALUout = 16'h1BEA; 
	rd1 = 16'h0BEA; rd15 = 16'h1BEA;
	op1 = 4'b0000; op2 = 4'b1111;
	regWrite = 3'b101;
	w = 1'b0; r = 1'b1; sb = 1'b0; F = 1'b1;
end

initial
	forever #10 clk = ~clk;

initial
	#50 $finish;

endmodule
