`include "alu.v"

module alu_fixture;

reg [15:0] a, b;
reg [2:0] op;

wire [15:0] out, r15;
wire of;

alu alui(.a(a), .b(b), .op(op), .out(out), .r15(r15), .of(of));

initial
	$vcdpluson;

initial
begin
	$display("TIME\tOP\tA\tB\tR15\tOUT\tOF");
	$monitor("%3d\t%b\t%h\t%h\t%h\t%h\t%b", $time, op, a, b, r15, out, of);
end

initial
begin
	op = 3'b000; a = 16'h0F00; b = 16'h0050;
	#10 op = 3'b001; a = 16'h0F50; b = 16'h0050;
	#10 op = 3'b010; a = 16'h0040; b = 16'h6666;
	#10 op = 3'b011; a = 16'h0F00; b = 16'h9980;
	#10 op = 3'b100; a = 16'hFFFF; b = 16'h4C;
	#10 op = 3'b101; a = 16'hFF0F; b = 16'hFF;
	#10 op = 3'b110; a = 16'h0000; b = 16'h0001;
end

endmodule
