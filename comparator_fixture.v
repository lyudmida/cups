`include "comparator.v"

module comparator_fixture;

reg [15:0] rd1, rd15;
reg [3:0] cmp;

wire br;

comparator cmpi(.rd1(rd1), .rd15(rd15), .cmp(cmp), .br(br));

initial
	$vcdpluson;

initial
begin
	$display("TIME\tOPCODE\tOP1\tR15\tBR");
	$monitor("%3d\t%b\t%h\t%h\t%b", $time, cmp, rd1, rd15, br);
end

initial
begin
	cmp = 4'b0101; rd1 = 16'h0000; rd15 = 16'h0001;
	#10 cmp = 4'b0100; rd1 = 16'h0001; rd15 = 16'h0000;
	#10 cmp = 4'b0110; rd1 = 16'h0000; rd15 = 16'h0000;
	#10 cmp = 4'b0110; rd1 = 16'h0000; rd15 = 16'h0001;
end

endmodule
