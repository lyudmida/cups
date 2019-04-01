//Hazard Detection Unit

module hazard (input [3:0] ifidOP1, ifidOP2, idexOP1,
	       input idexR, w,
	       output reg pcdrive, stall);

always@(*)
begin
	pcdrive = 1'b0;
	if (w == 1'b0 && idexR && ((idexOP1 == ifidOP2) || (idexOP1 == ifidOP1)) &&
		(ifidOP1 != 0) && (ifidOP2 != 0))
	begin
		pcdrive = 1'b0;
		stall = 1'b1;
	end

	else
	begin
		pcdrive = 1'b1;
		stall = 1'b0;
	end
end

endmodule
