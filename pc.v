//Program Counter

module pc (input clk, reset, pcdrive, of, stahp,
	   input [15:0] in,
	   output reg [15:0] out);

reg [15:0] count;

always@(posedge clk or negedge reset)
begin
	if(!reset)
	begin
		count <= 16'h0000;
	end
	else
	begin
		if (pcdrive == 1'b1 && !of && stahp == 1'b0)
			count <= in;
		else //if(pcdrive == 1'b0)
		
			count <= count;
	end
end

always@(*)
begin
	out = count;
end

endmodule
