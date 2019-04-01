`include "cu.v"

module cu_fixture;

reg [15:0] code;
wire [3:0] cmp, fc;	/*compare, function code*/
wire [2:0] C, D, regWrite;
wire [1:0] aoi, B;	/*ANDi, ORi*/
wire A, F, G, sz, sb, w, r, stahp;

cu cui(.code(code), .cmp(cmp), .fc(fc), .C(C), .D(D), .regWrite(regWrite),
	.aoi(aoi), .A(A), .B(B), .F(F), .G(G), .sz(sz), . sb(sb), .w(w), .r(r), .stahp(stahp));

initial
	$vcdpluson;

initial
begin
	$display("TIME\t  OP  A B   D   C  F G regWrite SZ SB  CMP  AOI  FC  W R staph");
	$monitor("%3d\t %4b %b %b %b %b %b %b   %b    %b  %b   %b %b  %b %b %b   %b\n",
		$time, code[15:12], A, B, D, C, F, G, regWrite, sz, sb, cmp, aoi, fc, w, r, stahp);
end

initial
begin
	code[15:12] = 4'b1111;
		code[3:0] = 4'b0000;
	#10	code[3:0] = 4'b0001;
	#10	code[3:0] = 4'b0100;
	#10	code[3:0] = 4'b0101;
	#10	code[3:0] = 4'b0111;
	#10	code[3:0] = 4'b1000;

	#10 code[15:12] = 4'b1000;
	#10 code[15:12] = 4'b1001;
	#10 code[15:12] = 4'b1010;
	#10 code[15:12] = 4'b1011;
	#10 code[15:12] = 4'b1100;
	#10 code[15:12] = 4'b1101;
	#10 code[15:12] = 4'b0101;
	#10 code[15:12] = 4'b0100;
	#10 code[15:12] = 4'b0110;
	#10 code[15:12] = 4'b0001;
	#10 code[15:12] = 4'b0000;
end

endmodule
