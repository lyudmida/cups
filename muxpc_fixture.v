`include "muxpc.v"

module muxpc_fixture;

/*reg [15:0] a, b;
reg [1:0] s;

wire [15:0] f;

muxpc mxpc(.a(a), .b(b), .s(s), .f(f));
*/
reg [15:0] a, b;
reg s1, s2;

wire [15:0] f;

muxpc mxpc(.a(a), .b(b), .s1(s1), .s2(s2), .f(f));

initial
	$vcdpluson;

initial
begin
	a = 16'h0000;
	b = 16'h0001;

	s1 = 1'b0;
	#5 $display("s1=%b s2=%b:  \tf = %h", s1, s2, f);
	
	s1 = 1'b0; s2 = 1'b1;
	#5 $display("s1=%b s2=%b:  \tf = %h", s1, s2, f);

	s2 = 1'b1;
	#5 $display("s1=%b s2=%b:  \tf = %h", s1, s2, f);
end

endmodule
