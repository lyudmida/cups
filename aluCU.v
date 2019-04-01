//ALU Control Unit

module aluCU (input [1:0] aoi,	/*ANDi, ORi*/
	      input [3:0] functionCode,
	      output reg [2:0] op);

always@(*)
begin
	if (functionCode == 4'b0000)
		op = 3'b000;
	else if (functionCode == 4'b0001)
		op = 3'b001;
	else if (functionCode == 4'b0100)
		op = 3'b010;
	else if (functionCode == 4'b0101)
		op = 3'b011;
	else if (functionCode == 4'b0111 || functionCode == 4'b1000)
		op = 3'b110;

	else if (aoi == 2'b01)
		op = 3'b100;
	else if (aoi == 2'b10)
		op = 3'b101;
	else
		op = 3'b000;
end

endmodule
