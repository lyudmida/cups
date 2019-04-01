`include "aluCU.v"

module aluCU_fixture;

reg [1:0] aoi;
reg [3:0] functionCode;
wire [2:0] op;

aluCU aluCUi(.aoi(aoi), .functionCode(functionCode), .op(op));

initial
	$vcdpluson;

initial
begin
	aoi = 2'b10;
	#5 $display("aoi=%b op=%b", aoi, op);
	
	aoi = 2'b01;
	#5 $display("aoi=%b op=%b", aoi, op);

	aoi = 2'b0x;
	#5 $display("aoi=%b op=%b", aoi, op);

	functionCode = 4'b0000;
	#5 $display("fc=%b op=%b", functionCode, op);

	functionCode = 4'b0101;
	#5 $display("fc=%b op=%b", functionCode, op);

	functionCode = 4'b1000;
	#5 $display("fc=%b op=%b", functionCode, op);
end

endmodule
