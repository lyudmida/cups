`include "instrMem.v"

module instrMem_fixture;

reg clk, reset;
reg [15:0] pcout;

wire [15:0] instruction;

instrMem im(.clk(clk), .reset(reset), .pcout(pcout), .instruction(instruction));

initial
	$vcdpluson;

initial
begin
	$display("TIME\tCLK\tRST\tPC\tINSTR");
	$monitor("%3d\t%b\t%b\t%h\t%h\t", $time, clk, reset, pcout, instruction);
end

initial
begin
	clk = 1'b0; reset = 1'b0;
	#10 reset = 1'b1; pcout = 16'h0000;
	#10 pcout = 16'h0002;
	#10 pcout = 16'h0004;
end

initial
begin
	forever #10 clk = ~clk;
end

initial
begin
	#40 $finish;
end

endmodule
