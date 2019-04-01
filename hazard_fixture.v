`include "hazard.v"

module hazard_fixture;

reg [3:0] ifidOP1, ifidOP2, idexOP1;
reg idexR, w;

wire pcdrive, stall;

hazard hazardi (.ifidOP1(ifidOP1), .ifidOP2(ifidOP2),
		.idexOP1(idexOP1), .idexR(idexR), .w(w), .pcdrive(pcdrive), .stall(stall));

initial
begin
	$display("TIME\t ifidOP1 ifidOP2 idexOP1 idexR\t w PCDRIVE  stall");
	$monitor("%4d\t  %b\t  %b\t  %b\t   %b\t %b    %b\t      %b", $time, ifidOP1,
		ifidOP2, idexOP1, idexR, w, pcdrive, stall);
end

initial
begin
	ifidOP1 = 4'b1111;
	ifidOP2 = 4'b1111;
	idexOP1 = 4'b1111;
	idexR = 1'b1;
	w = 1'b0;
	#10
	ifidOP1 = 4'b0000;
	ifidOP2 = 4'b0001;
	idexOP1 = 4'b0010;
	idexR = 1'b0;
	w = 1'b0;
	#10
	ifidOP1 = 4'b0011;
	ifidOP2 = 4'b0100;
	idexOP1 = 4'b0101;
	idexR = 1'b1;
	w = 1'b1;
end

endmodule
