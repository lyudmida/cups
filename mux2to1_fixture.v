`include "mux2to1.v"

module mux2to1_fixture;

reg [15:0] a, b;
reg s;

wire [15:0] f;

mux2to1 mx21(.a(a), .b(b), .s(s), .f(f));

initial
	$vcdpluson;

initial
begin
	a = 16'h0000;
	b = 16'h0001;

	s = 0;
	#5 $display("s=%b:  f = %h", s, f);
	
	s = 1;
	#5 $display("s=%b:  f = %h", s, f);

end

endmodule
