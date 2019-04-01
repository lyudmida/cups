module mux5to1 (input [15:0] a0, a1, a2, a3, a4,
		input [2:0] s1, s2,
		output reg [15:0] f);

always@(*)
begin
	if (s1 == 3'b100)
		f = a4;
	else if (s2 == 3'b001)
		f = a1;
	else if (s2 == 3'b010)
		f = a2;
	else if (s2 == 3'b011)
		f = a3;
	else
		f = a0;

end

endmodule
