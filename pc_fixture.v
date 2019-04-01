`include "pc.v"

module pc_fixture;

reg clk, reset, pcdrive, of, stahp;
reg [15:0] in;

wire [15:0] out;

pc pci(.clk(clk), .reset(reset), .pcdrive(pcdrive), .of(of), .stahp(stahp), .in(in), .out(out));

initial
	$vcdpluson;

initial
begin
	$display("TIME\tCLK\tRST\tPCDRIVE\t OF\t STAHP\t IN\tOUT");
	$monitor("%3d\t %b\t %b\t   %b\t %b\t  %b\t%h\t%h\t", $time, clk, reset, pcdrive, of, stahp, in, out);
end

initial
begin
	clk = 1'b0; reset = 1'b0; pcdrive = 1'b0; of = 1'b0; stahp = 1'b0;
	#5 reset = 1'b1;
	    pcdrive = 1'b1; in = 16'hAAAA;
	#15 pcdrive = 1'b1; in = 16'h0000;
	#15 pcdrive = 1'b0; in = 16'h1234;
	#15 pcdrive = 1'b1; in = 16'hA1A1;
	#15;
end

initial
begin
	forever #5 clk = ~clk;
end

initial
begin
	#70 $finish;
end

endmodule
