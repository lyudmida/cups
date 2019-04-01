module muxpc (input [15:0] a, b,
		input s1, s2,
		output reg [15:0] f);

always@(*)
begin
	if (s2 == 1'b1)	//branch
		f = b;
	else if (s1 == 1'b1)	//jump
		f = b;
	else
		f = a;
end

endmodule
