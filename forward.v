//Forwarding Unit

module forward (input [3:0] idexOP1, idexOP2, exmemOP1, memwbOP1,
		input [2:0] exmemregWrite, memwbregWrite,
		input exmemW,
		output reg [2:0] C, D,
		output reg E);

always@(*)
begin
	C = 3'bxxx;
	D = 3'bxxx;
	E = 1'b0;

	if (memwbregWrite && (memwbOP1 != 0) && (memwbOP1 == idexOP1))
		D = 3'b001;

	if (memwbregWrite && (memwbOP1 != 0) && (memwbOP1 == idexOP2))
		C = 3'b001;


	if (exmemregWrite && (exmemOP1 != 0) && (exmemOP1 == idexOP1))
		D = 3'b010;
	if (exmemregWrite && (exmemOP1 != 0) && (exmemOP1 == idexOP2))
		C = 3'b010;

	if (exmemregWrite[2] && (idexOP1 == 4'b1111) && (exmemOP1 == idexOP1))
		D = 3'b011;
	if (exmemregWrite[2] && (idexOP2 == 4'b1111) && (exmemOP1 == idexOP2))
		C = 3'b011;

	if (memwbregWrite && exmemW && (memwbOP1 != 0) && (memwbOP1 == exmemOP1))
		E = 1'b1;
end

endmodule
