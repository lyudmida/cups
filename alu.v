//ALU

module alu (input signed [15:0] a, b,
	    input [2:0] op,
	    output reg [15:0] out, r15,
	    output reg of);

reg [16:0] check;

always@(*)
begin
	out = 16'hxxxx;
	r15 = 16'hxxxx;

	if (op == 3'b000)	//Signed Addition
	begin
		out = a + b;
		check = a + b;
		of = check[16];
	end
	else if (op == 3'b001)	//Signed Subtraction
		out = a - b;
	else if (op == 3'b010)	//Signed Multiplication
		{r15, out} = a * b;
	else if (op == 3'b011)	//Signed Division
	begin
		out = a / b;
		r15 = a % b;
	end
	else if (op == 3'b100)	//ANDi
		out = a & b;
	else if (op == 3'b101)	//ORi
		out = a | b;
	else if (op == 3'b110)	
		out = b;	//b for MOV and SWP
end

endmodule
