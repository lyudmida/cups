`include "moduleB.v"

module moduleB_fixture;

reg [3:0] tb; /*aoi*/
reg [7:0] tc; /*branch*/
reg [11:0] td;/*jump*/
reg [1:0] B;
reg sz;
wire [15:0] out;

moduleB mx31(.tb(tb), .tc(tc), .td(td), .B(B), .sz(sz), .out(out));

initial
	$vcdpluson;

initial
begin
	tb = 4'h0;
	tc = 8'h01;
	td = 12'h010;

	B = 2'b00;
	#5 $display("B=%b:  out = %h", B, out);
	
	tb = 4'h1;
	tc = 8'h11;
	td = 12'h10;
	B = 2'b01;
	#5 $display("B=%b:  out = %h", B, out);

end

endmodule
