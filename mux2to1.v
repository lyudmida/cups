module mux2to1 (input [15:0] a, b,
		input s,
		output reg [15:0] f);

always@(*)
	if (s == 1'b0)
		f = a;
	else
		f = b;

endmodule
