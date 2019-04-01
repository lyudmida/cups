//Control Unit

module cu (input [15:0] code,
	   output reg [3:0] cmp, fc,	/*compare, function code*/
	   output reg [2:0] C, D, regWrite,
	   output reg [1:0] aoi, B,	/*ANDi, ORi*/
	   output reg A, F, G, sz, sb, w, r, stahp);

wire [3:0] opcode;
wire [3:0] functionCode;

assign opcode = code[15:12];
assign functionCode = code[3:0];

always@(*)
begin
	if (opcode == 4'b1111)
	begin
		if (functionCode == 4'b0000)	//Signed Addition
		begin
			stahp = 1'b0;
			A = 1'b0;
			B = 2'bxx;
			C = 3'b000;
			D = 3'b000;
			F = 1'b1;
			G = 1'b0;
			regWrite = 3'b001;
			sz = 1'bx;
			sb = 1'bx;
			cmp = 4'bxxxx;
			aoi = 2'bxx;
			fc = functionCode;
			w = 1'b0;
			r = 1'b0;
		end

		if (functionCode == 4'b0001)	//Signed Subtraction
		begin
			stahp = 1'b0;
			A = 1'b0;
			B = 2'bxx;
			C = 3'b000;
			D = 3'b000;
			F = 1'b1;
			G = 1'b0;
			regWrite = 3'b001;
			sz = 1'bx;
			sb = 1'bx;
			cmp = 4'bxxxx;
			aoi = 2'bxx;
			fc = functionCode;
			w = 1'b0;
			r = 1'b0;
		end

		if (functionCode == 4'b0100)	//Signed Multiplication
		begin
			stahp = 1'b0;
			A = 1'b0;
			B = 2'bxx;
			C = 3'b000;
			D = 3'b000;
			F = 1'b1;
			G = 1'b0;
			regWrite = 3'b101;
			sz = 1'bx;
			sb = 1'bx;
			cmp = 4'bxxxx;
			aoi = 2'bxx;
			fc = functionCode;
			w = 1'b0;
			r = 1'b0;
		end

		if (functionCode == 4'b0101)	//Signed Division
		begin
			stahp = 1'b0;
			A = 1'b0;
			B = 2'bxx;
			C = 3'b000;
			D = 3'b000;
			F = 1'b1;
			G = 1'b0;
			regWrite = 3'b101;
			sz = 1'bx;
			sb = 1'bx;
			cmp = 4'bxxxx;
			aoi = 2'bxx;
			fc = functionCode;
			w = 1'b0;
			r = 1'b0;
		end

		if (functionCode == 4'b0111)	//Move
		begin
			stahp = 1'b0;
			A = 1'b0;
			B = 2'bxx;
			C = 3'b000;
			D = 3'bxxx;
			F = 1'b1;
			G = 1'b1;
			regWrite = 3'b001;
			sz = 1'bx;
			sb = 1'bx;
			cmp = 4'bxxxx;
			aoi = 2'bxx;
			fc = functionCode;
			w = 1'b0;
			r = 1'b0;
		end

		if (functionCode == 4'b1000)	//SWAP
		begin
			stahp = 1'b0;
			A = 1'b0;
			B = 2'bxx;
			C = 3'b000;
			D = 3'b000;
			F = 1'b1;
			G = 1'b0;
			regWrite = 3'b011;
			sz = 1'bx;
			sb = 1'bx;
			cmp = 4'bxxxx;
			aoi = 2'bxx;
			fc = functionCode;
			w = 1'b0;
			r = 1'b0;
		end
	end

	else if (opcode == 4'b1000)		//AND Immediate
	begin
		stahp = 1'b0;
		A = 1'b0;
		B = 2'b01;
		C = 3'b100;
		D = 3'b000;
		F = 1'b1;
		G = 1'b0;
		regWrite = 3'b001;
		sz = 1'b0;
		sb = 1'bx;
		cmp = 4'bxxxx;
		aoi = 2'b01;
		fc = 4'bxxxx;
		w = 1'b0;
		r = 1'b0;
	end

	else if (opcode == 4'b1001)		//OR Immediate
	begin
		stahp = 1'b0;
		A = 1'b0;
		B = 2'b01;
		C = 3'b100;
		D = 3'b000;
		F = 1'b1;
		G = 1'b0;
		regWrite = 3'b001;
		sz = 1'b0;
		sb = 1'bx;
		cmp = 4'bxxxx;
		aoi = 2'b10;
		fc = 4'bxxxx;
		w = 1'b0;
		r = 1'b0;
	end

	else if (opcode == 4'b1010)		//Load Byte Unsigned
	begin
		stahp = 1'b0;
		A = 1'b0;
		B = 2'b00;
		C = 3'b100;
		D = 3'b100;
		F = 1'b0;
		G = 1'b0;
		regWrite = 3'b001;
		sz = 1'b1;
		sb = 1'b1;
		cmp = 4'bxxxx;
		aoi = 2'bxx;
		fc = 4'bxxxx;
		w = 1'b0;
		r = 1'b1;
	end

	else if (opcode == 4'b1011)		//Store Byte
	begin
		stahp = 1'b0;
		A = 1'b0;
		B = 2'b00;
		C = 3'b100;
		D = 3'b100;
		F = 1'bx;
		G = 1'b0;
		regWrite = 3'b000;
		sz = 1'b1;
		sb = 1'b1;
		cmp = 4'bxxxx;
		aoi = 2'bxx;
		fc = 4'bxxxx;
		w = 1'b1;
		r = 1'b0;
	end

	else if (opcode == 4'b1100)		//Load
	begin
		stahp = 1'b0;
		A = 1'b0;
		B = 2'b00;
		C = 3'b100;
		D = 3'b100;
		F = 1'b0;
		G = 1'b0;
		regWrite = 3'b001;
		sz = 1'b1;
		sb = 1'b0;
		cmp = 4'bxxxx;
		aoi = 2'bxx;
		fc = 4'bxxxx;
		w = 1'b0;
		r = 1'b1;
	end

	else if (opcode == 4'b1101)		//Store
	begin
		stahp = 1'b0;
		A = 1'b0;
		B = 2'b00;
		C = 3'b100;
		D = 3'b100;
		F = 1'bx;
		G = 1'b0;
		regWrite = 3'b000;
		sz = 1'b1;
		sb = 1'b0;
		cmp = 4'bxxxx;
		aoi = 2'bxx;
		fc = 4'bxxxx;
		w = 1'b1;
		r = 1'b0;
	end

	else if (opcode == 4'b0101)		//Bacon Lettuce Tomato
	begin
		stahp = 1'b0;
		A = 1'b0;
		B = 2'b01;
		C = 3'bxxx;
		D = 3'bxxx;
		F = 1'bx;
		G = 1'b0;
		regWrite = 3'bxxx;
		sz = 1'b1;
		sb = 1'bx;
		cmp = opcode;
		aoi = 2'bxx;
		fc = 4'bxxxx;
		w = 1'b0;
		r = 1'b0;
	end

	else if (opcode == 4'b0100)		//Branch on Greater Than
	begin
		stahp = 1'b0;
		A = 1'b0;
		B = 2'b01;
		C = 3'bxxx;
		D = 3'bxxx;
		F = 1'bx;
		G = 1'b0;
		regWrite = 3'bxxx;
		sz = 1'b1;
		sb = 1'bx;
		cmp = opcode;
		aoi = 2'bxx;
		fc = 4'bxxxx;
		w = 1'b0;
		r = 1'b0;
	end

	else if (opcode == 4'b0110)		//Branch on Equal
	begin
		stahp = 1'b0;
		A = 1'b0;
		B = 2'b01;
		C = 3'bxxx;
		D = 3'bxxx;
		F = 1'bx;
		G = 1'b0;
		regWrite = 3'bxxx;
		sz = 1'b1;
		sb = 1'bx;
		cmp = opcode;
		aoi = 2'bxx;
		fc = 4'bxxxx;
		w = 1'b0;
		r = 1'b0;
	end

	else if (opcode == 4'b0001)		//Jump
	begin
		stahp = 1'b0;
		A = 1'b1;
		B = 2'b10;
		C = 3'bxxx;
		D = 3'bxxx;
		F = 1'bx;
		G = 1'b0;
		regWrite = 3'bxxx;
		sz = 1'b1;
		sb = 1'bx;
		cmp = 4'bxxxx;
		aoi = 2'bxx;
		fc = 4'bxxxx;
		w = 1'b0;
		r = 1'b0;
	end

	else if (opcode == 4'b0000)		//Halt
	begin
		stahp = 1'b0;
		A = 1'bx;
		B = 2'bxx;
		C = 3'bxxx;
		D = 3'bxxx;
		F = 1'bx;
		G = 1'bx;
		regWrite = 3'bxxx;
		sz = 1'bx;
		sb = 1'bx;
		cmp = 4'bxxxx;
		aoi = 2'bxx;
		fc = 4'bxxxx;
		w = 1'b0;
		r = 1'b0;
	end
	else
		stahp = 1'b1;
		
end

endmodule
