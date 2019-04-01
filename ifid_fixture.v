`include "ifid.v"

module ifid_fixture;

reg clk, reset, flush;
reg [15:0] instruction, pc;


wire [15:0] ifidPC, ifidInstr;

ifid ifidi(.clk(clk), .reset(reset), .stall(flush), .instruction(instruction), .pc(pc),
		.ifidPC(ifidPC), .ifidInstr(ifidInstr));

initial
	$vcdpluson;

initial
begin
	$display("TIME\t CLK   RESET   FLUSH\t  PC\t INSTR");

	$monitor("%2d\t %b\t %b\t %b\t %h\t %h", $time, clk, reset, flush, ifidPC, ifidInstr);
end

initial
begin
	clk = 1'b0; reset = 1'b0;

	#5 reset = 1'b1;
	flush = 1'b0;	pc = 16'h0101;	instruction = 16'hAAAA;

	#15	flush = 1'b0;	pc = 16'h0101;	instruction = 16'hAAAA;
	#15	flush = 1'b1;	pc = 16'h0101;	instruction = 16'hAAAA;
end

initial
begin
	forever #10 clk = ~clk;
end

initial
begin
	#90 $finish;
end

endmodule
