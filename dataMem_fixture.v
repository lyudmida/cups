`include "dataMem.v"

module dataMem_fixture;

reg clk, reset, w, r, sb;
reg [15:0] wa, wd;

wire [15:0] rd;
wire [15:0] m0, m1, m2, m3, m4;

dataMem dataMemi (.clk(clk), .reset(reset), .w(w), .r(r), .sb(sb), .wa(wa), .wd(wd), .rd(rd),
		  .m0(m0), .m1(m1), .m2(m2), .m3(m3), .m4(m4));

initial
	$vcdpluson;

initial
begin
	$display("TIME\t CLK RST W R SB  WA   WD   RD   M0   M1   M2   M3   M4");
	$monitor("%3d\t  %b   %b  %b %b %b  %h %h %h %h %h %h %h %h",
		$time, clk, reset, w, r, sb, wa, wd, rd, m0, m1, m2, m3, m4);
end

initial
begin
	clk = 1'b0; reset = 1'b0;
	#5;

	reset = 1'b1;	
	w = 1'b1; r = 1'b0;
	wa = 16'hacbd;
	#10 w = 1'b1; sb = 1'b1;
	#10 w = 1'b0; r = 1'b1;
	#10 wa = 16'hacbd; wd = 16'h0001;
	#10 sb = 1'b1;
end

initial
	forever #10 clk = ~clk;

initial
	#50 $finish;

endmodule


