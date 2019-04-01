`include "memwb.v"

module memwb_fixture;

reg clk, reset, of;
reg [15:0] rd, ALUout, rd1, rd15;
reg [3:0] op1, op2;
reg [2:0] regWrite;
reg F;

wire [15:0] memwbRD, memwbALUout, memwbRD1, memwbRD15;
wire [3:0] memwbOP1, memwbOP2;
wire [2:0] memwbregWrite;
wire memwbF;

memwb memwbi(.clk(clk), .reset(reset), .of(of), .rd(rd), .ALUout(ALUout), .rd1(rd1), .rd15(rd15),
	.op1(op1), .op2(op2), .regWrite(regWrite), .F(F), .memwbRD(memwbRD),
	.memwbALUout(memwbALUout), .memwbRD1(memwbRD1), .memwbRD15(memwbRD15),
	.memwbOP1(memwbOP1), .memwbOP2(memwbOP2), .memwbregWrite(memwbregWrite), .memwbF(memwbF));

initial
	$vcdpluson;

initial
begin
	$display("TIME CLK RESET ALUout   RD RD15\t OP1\t OP2\t  RW F");
	$monitor("%3d   %b    %b    %h  %h %h\t %b\t %b\t %b  %b", $time, clk, reset,
		memwbALUout, memwbRD, memwbRD15, memwbOP1, memwbOP2, memwbregWrite, memwbF);
end

initial
begin
	clk = 1'b0; reset = 1'b0;
	#5 reset = 1'b1;

	ALUout = 16'hA0A0; 
	rd = 16'h0A0A; rd15 = 16'h0098;
	op1 = 4'b0001; op2 = 4'b0010;
	regWrite = 3'b001;
	F = 1'b0;

	#20
	ALUout = 16'h1BEA; 
	rd = 16'h0BEA; rd15 = 16'h1BEA;
	op1 = 4'b0000; op2 = 4'b1111;
	regWrite = 3'b100;
	F = 1'b1;

	#20 of = 1'b1;
	ALUout = 16'h1BEA; 
	rd = 16'h0BEA; rd15 = 16'h1BEA;
	op1 = 4'b0000; op2 = 4'b1111;
	regWrite = 3'b100;
	F = 1'b1;
end

initial
	forever #10 clk = ~clk;

initial
	#90 $finish;

endmodule
