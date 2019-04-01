`include "adder.v"

module adder_fixture;

reg [15:0] a, b;

wire [15:0] f;

adder adderi(.a(a), .b(b), .f(f));

initial
	$vcdpluson;

initial
begin
	$monitor("%h + %h = %h", a, b, f);
end

initial
begin
	a = 0; b = 0;
	#10 a = 0; b = 1;
	#10 a = 1; b = 0;
	#10 a = 1; b = 1;
end

endmodule
