//Sign or Zero Extend

module szextend (input [7:0] in,
		 input s,
		 output reg [15:0] out);

always@(*)
begin
	out = 16'hxxxx;
	if (s == 1'b0)
		out = {8'b0, in[7:0]};
	else if (s == 1'b1)
	begin
		if (in[3] == 1'b0)
			out = {12'h000, in[3:0]};
		else if (in[3] == 1'b1)
			out = {12'hFFF, in[3:0]};
	end
end

endmodule
