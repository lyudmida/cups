//ADDER

module adder (input [15:0] a, b,
	      output reg [15:0] f);

always@(*)
begin
	assign f = a + b;
end

endmodule
