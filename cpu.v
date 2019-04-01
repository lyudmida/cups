module cpu (input clk, reset,
	    output reg [15:0] PCOUT, INSTRUCTION, IFADDER, IFIDINSTR,


	    output reg [15:0] RD1, RD2,
	    output reg [3:0] RR1, RR2,
	    output reg [15:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15,

	    output reg [15:0] IDEXRD1, IDEXRD2, IDEXSZOUT,

	    output reg [15:0] MUXC, MUXD, ALUOUT, ALUR15,

            output reg [15:0] EXMEMALU, EXMEMRD1,

	    output reg [15:0] RD,

	    output reg [15:0] MEMWBRD, MEMWBALUOUT, MEMWBRD1, MUXF, MEMWBRD15, MUXE,

	    output reg [15:0] M0, M1, M2, M3, M4);



//---IF---//
wire A, branch, pcdrive;
wire [15:0] ifadder, idadder, muxA, pcout, instruction;


//--IFID--//
wire [15:0] ifidPC, ifidInstr;


//---ID---//
wire [15:0] rd1, rd2, rd15, muxF, szout, shift;
wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
wire [3:0] cmp, fc, rr1, rr2;
	assign rr1 = ifidInstr[11:8];
	assign rr2 = ifidInstr[7:4];
wire [2:0] C, D, regWrite;
wire [1:0] aoi, B;
wire F, G, sz, sb, w, r, br, stall, stahp;


//--IDEX--//
wire [15:0] idexRD1, idexRD2, idexSZOUT;
wire [3:0] idexOP1, idexOP2, idexFC;
wire [2:0] idexC, idexD, idexregWrite;
wire [1:0] idexAOI;
wire idexW, idexR, idexSB, idexF, idexG;


//---EX---//
wire [15:0] muxC, muxD, muxG, ALUout, ALUr15;
wire [2:0] forwardC, forwardD, op;
wire forwardE;



//--EXMEM--//
wire [15:0] exmemALUout, exmemRD1, exmemRD15;
wire [3:0] exmemOP1, exmemOP2;
wire [2:0] exmemregWrite;
wire exmemW, exmemR, exmemSB, exmemF;


//---MEM---//
wire [15:0] rd, muxE;
wire [15:0] m0, m1, m2, m3, m4;


//--MEMWB--//
wire [15:0] memwbRD, memwbALUout, memwbRD1, memwbRD15;
wire [3:0] memwbOP1, memwbOP2;
wire [2:0] memwbregWrite;
wire memwbF, of;


//========================================Instruction Fetch========================================//
muxpc		alpha (.a(ifadder), .b(idadder), .s1(A), .s2(br), .f(muxA));

pc		pc (.clk(clk), .reset(reset), .pcdrive(pcdrive), .of(of), .stahp(stahp), .in(muxA), .out(pcout));

adder 		IFadder (.a(pcout), .b(16'h0002), .f(ifadder));

instrMem	IM (.clk(clk), .reset(reset), .pcout(pcout), .instruction(instruction));
//=================================================================================================//


ifid		IFID (.clk(clk), .reset(reset), .stall(stall),
		      .instruction(instruction), .pc(pcout),
		      .ifidPC(ifidPC), .ifidInstr(ifidInstr));


//========================================Instruction Decode=======================================//
hazard		hazardUnit (.ifidOP1(rr1), .ifidOP2(rr2),
			    .idexOP1(idexOP1), .idexR(idexR), .w(w), .pcdrive(pcdrive), .stall(stall));

cu		controlUnit (.code(ifidInstr), .cmp(cmp), .fc(fc), .C(C), .D(D), .regWrite(regWrite),
			     .aoi(aoi), .A(A), .B(B), .F(F), .G(G), .sz(sz), .sb(sb), .w(w), .r(r), .stahp(stahp));

regFile		registerFile (.clk(clk), .reset(reset), .regWrite(memwbregWrite), .rr1(rr1),
			      .rr2(rr2), .wr(memwbOP1), .wr2(memwbOP2), .wd(muxF), .wd2(memwbRD1),
			      .wd15(memwbRD15), .rd1(rd1), .rd2(rd2), .rd15(rd15), .r0(r0), .r1(r1),
			      .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7), .r8(r8), .r9(r9),
			      .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15));

comparator	comp (.rd1(rd1), .rd15(rd15), .cmp(cmp), .br(br));

moduleB		bravo (.tb(ifidInstr[3:0]), .tc(ifidInstr[7:0]), .td(ifidInstr[11:0]),
		       .B(B), .sz(sz), .out(szout));

shift 		shift1 (.in(szout), .out(shift));

adder		IDadder (.a(ifidPC), .b(shift), .f(idadder));
//=================================================================================================//


idex		IDEX (.clk(clk), .reset(reset), .stall(stall), .rd1(rd1), .rd2(rd2), .szout(szout),
		.op1(rr1), .op2(rr2), .fc(fc), .C(C), .D(D),
		.regWrite(regWrite), .aoi(aoi), .w(w), .r(r), .sb(sb), .F(F), .G(G), .idexRD1(idexRD1),
		.idexRD2(idexRD2), .idexSZOUT(idexSZOUT), .idexOP1(idexOP1), .idexOP2(idexOP2),
		.idexFC(idexFC), .idexC(idexC), .idexD(idexD), .idexregWrite(idexregWrite),
		.idexAOI(idexAOI), .idexW(idexW), .idexR(idexR), .idexSB(idexSB), .idexF(idexF),
		.idexG(idexG));


//============================================Execution============================================//
mux5to1		charlie (.a0(idexRD2), .a1(muxF), .a2(exmemALUout), .a3(exmemRD15), .a4(idexSZOUT),
			 .s1(idexC), .s2(forwardC), .f(muxC));

mux5to1		delta (.a0(idexRD1), .a1(muxF), .a2(exmemALUout), .a3(exmemRD15), .a4(idexRD2),
			 .s1(idexD), .s2(forwardD), .f(muxD));

alu		ALU (.a(muxD), .b(muxC), .op(op), .out(ALUout), .r15(ALUr15), .of(of));

aluCU		controlALU(.aoi(idexAOI), .functionCode(idexFC), .op(op));

mux2to1		golf (.a(muxD), .b(idexRD1), .s(idexG), .f(muxG));

forward		forwardingUnit (.idexOP1(idexOP1), .idexOP2(idexOP2), .exmemOP1(exmemOP1),
		.memwbOP1(memwbOP1), .exmemregWrite(exmemregWrite), .exmemW(exmemW),
		.memwbregWrite(memwbregWrite), .C(forwardC), .D(forwardD), .E(forwardE));
//=================================================================================================//


exmem		EXMEM (.clk(clk), .reset(reset), .ALUout(ALUout), .rd1(muxG), .rd15(ALUr15),
		       .op1(idexOP1), .op2(idexOP2), .regWrite(idexregWrite), .w(idexW), .r(idexR),
		       .sb(idexSB), .F(idexF), .exmemALUout(exmemALUout), .exmemRD1(exmemRD1),
		       .exmemRD15(exmemRD15), .exmemOP1(exmemOP1), .exmemOP2(exmemOP2),
		       .exmemregWrite(exmemregWrite), .exmemW(exmemW), .exmemR(exmemR),
	               .exmemSB(exmemSB), .exmemF(exmemF));


//==============================================Memory==============================================//
dataMem		dataMemory (.clk(clk), .reset(reset), .w(exmemW), .r(exmemR), .sb(exmemSB),
			    .wa(exmemALUout), .wd(muxE), .rd(rd),
			    .m0(m0), .m1(m1), .m2(m2), .m3(m3), .m4(m4));

mux2to1		echo (.a(exmemRD1), .b(muxF), .s(forwardE), .f(muxE));
//==================================================================================================//


memwb		MEMWB (.clk(clk), .reset(reset), .of(of), .rd(rd), .ALUout(exmemALUout), .rd1(exmemRD1),
		       .rd15(exmemRD15), .op1(exmemOP1), .op2(exmemOP2), .regWrite(exmemregWrite),
		       .F(exmemF), .memwbRD(memwbRD), .memwbALUout(memwbALUout), .memwbRD1(memwbRD1),
		       .memwbRD15(memwbRD15), .memwbOP1(memwbOP1), .memwbOP2(memwbOP2),
		       .memwbregWrite(memwbregWrite), .memwbF(memwbF));


//============================================Write Back============================================//
mux2to1		foxtrot (.a(memwbRD), .b(memwbALUout), .s(memwbF), .f(muxF));
//==================================================================================================//



always@(posedge clk or negedge reset)
begin
	if (!reset)
	begin
		PCOUT <= 0;
		INSTRUCTION <= 0;
		IFADDER <= 0;
		IFIDINSTR <= 0;


		RD1 <= 0;
		RD2 <= 0;
		RR1 <= 0;
		RR2 <= 0;

		R0 <= 0;
		R1 <= 0;
		R2 <= 0;
		R3 <= 0;
		R4 <= 0;
		R5 <= 0;
		R6 <= 0;
		R7 <= 0;
		R8 <= 0;
		R9 <= 0;
		R10 <= 0;
		R11 <= 0;
		R12 <= 0;
		R13 <= 0;
		R14 <= 0;
		R15 <= 0;


		IDEXRD1 <= 0;
		IDEXRD2 <= 0;
		IDEXSZOUT <= 0;


		MUXC <= 0;
		MUXD <= 0;
		ALUOUT <= 0;
		ALUR15 <= 0;


		EXMEMALU <= 0;
		EXMEMRD1 <= 0;


		RD <= 0;

		M0 <= 0;
		M1 <= 0;
		M2 <= 0;
		M3 <= 0;
		M4 <= 0;

		MEMWBRD <= 0;
		MEMWBALUOUT <= 0;
		MEMWBRD1 <= 0;
		MUXF <= 0;
		MEMWBRD15 <= 0;
		MUXE <= 0;
	end
	else
	begin
		PCOUT <= pcout;
		INSTRUCTION <= instruction;
		IFADDER <= ifadder;
		IFIDINSTR <= ifidInstr;


		RD1 <= rd1;
		RD2 <= rd2;
		RR1 <= rr1;
		RR2 <= rr2;

		R0 <= r0;
		R1 <= r1;
		R2 <= r2;
		R3 <= r3;
		R4 <= r4;
		R5 <= r5;
		R6 <= r6;
		R7 <= r7;
		R8 <= r8;
		R9 <= r9;
		R10 <= r10;
		R11 <= r11;
		R12 <= r12;
		R13 <= r13;
		R14 <= r14;
		R15 <= r15;


		IDEXRD1 <= idexRD1;
		IDEXRD2 <= idexRD2;
		IDEXSZOUT <= idexSZOUT;


		MUXC <= muxC;
		MUXD <= muxD;
		ALUOUT <= ALUout;
		ALUR15 <= ALUr15;


		EXMEMALU <= exmemALUout;
		EXMEMRD1 <= exmemRD1;

		RD <= rd;

		M0 <= m0;
		M1 <= m1;
		M2 <= m2;
		M3 <= m3;
		M4 <= m4;

		MEMWBRD <= memwbRD;
		MEMWBALUOUT <= memwbALUout;
		MEMWBRD1 <= memwbRD1;
		MUXF <= muxF;
		MEMWBRD15 <= memwbRD15;
		MUXE <=muxE;
	end
end

endmodule
