`include "mux5to1.v"

module mux5to1_fixture;

reg [15:0] a0, a1, a2, a3, a4;
reg [2:0] s1, s2;

wire [15:0] f;

mux5to1 mx21(a0, a1, a2, a3, a4, s1, s2, f);

initial
	$vcdpluson;

initial
begin
	a0 = 16'h0000;
	a1 = 16'h0001;
	a2 = 16'h0010;
	a3 = 16'h0011;
	a4 = 16'h0101;

	s1 = 3'b100;
	//#5 $display("s1=%b s2=%b\t f = %h", s1, s2, f);
	
	s2 = 3'b001;
	#10 $display("s1=%b s2=%b\t f = %h", s1, s2, f);

	s1 = 3'b000;
	#10 $display("s1=%b s2=%b\t f = %h", s1, s2, f);

	s2 = 3'b000;
	#10 $display("s1=%b s2=%b\t f = %h", s1, s2, f);
end

endmodule
