`include "shift.v"

module shift_fixture;

reg [15:0] in;

wire [15:0] out;

shift shifti(.in(in), .out(out));

initial
	$vcdpluson;

initial
begin
	in = 8'b00000001;
	#5 $display("%b < 1 = %b", in, out);
	
	in = 8'b00000010;
	#5 $display("%b < 1 = %b", in, out);

	in = 8'b10000000;
	#5 $display("%b < 1 = %b", in, out);

end

endmodule
