//Data Memory

module dataMem (input clk, reset, w, r, sb,
		input [15:0] wa, wd,
		output reg [15:0] rd,

		output reg [15:0] m0, m1, m2, m3, m4);

reg [7:0] mem [65536:0]; //in bits

integer i;

always@(posedge clk or negedge reset)
begin
	if(!reset)
	begin
		mem[0] <= 8'hCD;
		mem[1] <= 8'h2B;
		mem[2] <= 8'h00;
		mem[3] <= 8'h00;
		mem[4] <= 8'h34;
		mem[5] <= 8'h12;
		mem[6] <= 8'hAD;
		mem[7] <= 8'hDE;
		mem[8] <= 8'hEF;
		mem[9] <= 8'hBE;
		for (i = 10; i < 65536; i = i + 1)
			mem[i] <= 8'h00;
	end
	else if (w == clk)
	begin
		if (sb == 1'b1)
			mem[wa] <= wd[7:0];
		else
		begin
			mem[wa] <= wd[7:0]; //lower byte
			mem[wa+1] <= wd[15:8]; //upper byte
		end
	end
end

always@(*)
begin
	rd = 16'hxxxx;
	if (r == 1'b1)
	begin
		rd = {mem[wa+1], mem[wa]};
		if (sb == 1'b1)
			rd = {8'h00, mem[wa]};
	end

	m0 = {mem[1], mem[0]};
	m1 = {mem[3], mem[2]};
	m2 = {mem[5], mem[4]};
	m3 = {mem[7], mem[6]};
	m4 = {mem[9], mem[8]};
end

endmodule
