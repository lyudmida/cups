`include "forward.v"

module forward_fixture;

reg [3:0] idexOP1, idexOP2, exmemOP1, memwbOP1;
reg [2:0] exmemregWrite, memwbregWrite;
reg exmemW;

wire [2:0] C, D;
wire E;

forward forwardi (.idexOP1(idexOP1), .idexOP2(idexOP2), .exmemOP1(exmemOP1), .memwbOP1(memwbOP1),
		  .exmemregWrite(exmemregWrite), .memwbregWrite(memwbregWrite), .exmemW(exmemW),
		  .C(C), .D(D), .E(E));

initial
begin
	$display("idexOP1 idexOP2 exmemOP1 memwbOP1 exmemRW memwbRW exmemW  C   D  E");
	$monitor("  %b    %b    %b     %b     %b     %b      %b   %b %b %b", idexOP1, idexOP2,
		exmemOP1, memwbOP1, exmemregWrite, memwbregWrite, exmemW, C, D, E);
end

initial
begin
	idexOP1 = 4'b0001; idexOP2 = 4'b000;
	exmemOP1 = 4'b0001; memwbOP1 = 4'b0001;
	exmemregWrite = 3'b001; memwbregWrite = 3'b010; exmemW = 1'b0;
	#10;

	idexOP1 = 4'b0010; idexOP2 = 4'b000;
	exmemOP1 = 4'b0001; memwbOP1 = 4'b0001;
	exmemregWrite = 3'b001; memwbregWrite = 3'b010; exmemW = 1'b0;
	#10;

	idexOP1 = 4'b0000; idexOP2 = 4'b000;
	exmemOP1 = 4'b0011; memwbOP1 = 4'b0001;
	exmemregWrite = 3'b010; memwbregWrite = 3'b010; exmemW = 1'b1;
end

endmodule
