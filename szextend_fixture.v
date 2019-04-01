`include "szextend.v"

module szextend_fixture;

reg [7:0] in;
reg s;

wire [15:0] out;

szextend szi(.in(in), .s(s), .out(out));

initial
	$vcdpluson;

initial
begin
	in = 8'b00000001;
	s = 0;
	#5 $display("s=%b:  out = %h", s, out);
	s = 1;
	#5 $display("s=%b:  out = %h", s, out);

	in = 8'b00001001;
	s = 0;
	#5 $display("s=%b:  out = %h", s, out);
	s = 1;
	#5 $display("s=%b:  out = %h", s, out);	
end

endmodule
