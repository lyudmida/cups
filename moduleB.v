module moduleB (input [3:0] tb, /*aoi*/
		input [7:0] tc, /*branch*/
		input [11:0] td,/*jump*/
		input [1:0] B,
		input sz,
		output reg [15:0] out);

always@(*)
begin
	out = 16'hxxxx;
	if (B == 2'b00) /*Type B*/
	begin
		if (tb[3] == 1'b0)
			out = {12'h000, tb};
		else
			out = {12'hFFF, tb};
	end
//		out = {12'hFFF, tb};

	else if (B == 2'b01) /*Type C*/
	begin
		if (tc[7] == 1'b0)
			out = {8'h00, tc};
		else
			out = {8'hFF, tc};
	end

	else if (B == 2'b10) /*Type D*/
		out = {4'hF, td};
end

endmodule
