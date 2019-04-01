//Comparator

module comparator (input [15:0] rd1, rd15,
		   input [3:0] cmp,
		   output reg br);

always@(*)
begin
	if ((rd1 < rd15) && (cmp == 4'b0101)) //BLT
		br = 1'b1;
	else if ((rd1 > rd15) && (cmp == 4'b0100)) //BGT
		br = 1'b1;
	else if ((rd1 == rd15) && (cmp == 4'b0110)) //BEQ
		br = 1'b1;
	else
		br = 1'b0;
end

endmodule
