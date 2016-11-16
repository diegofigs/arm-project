//Datapath

module DataPath(output reg mfc, output reg [31:0] IR_Out, StaReg_Out, input [3:0] cu_opcode, write_cu, readA_cu, readB_cu, input [1:0] Ma, dataType, imme_SEL, Mg,
				input RFen, Mb, Mc, Md, Me, Mf, Mo, Ms, Ml, MAREn, MDREn, IREn, SHFen, SignExtEn, SignExtEn2, r_w, MemEN, dwp, mfa, clk, clr, StatusRegEn_cu);
  
//Wires connected to other components

wire [31:0] RFOut_A, RFOut_B, BranchExt_Out, SignExt_Out, Ma_Out, Mb_Out, Mc_Out, Md_Out, Me_Out, 
            SignExt_Out2, ALU_Out, Shf_Out, MDR_Out, MAR_Out, MemOut, Flags;

wire [3:0] write, readA, readB, opcode_in, Ml_out;
reg carry;
wire StatusRegEn;

//assign write = wireIR[15:12];
assign write = Ml_out;

//Temp variables

wire [31:0] temp4, tempStaReg;
wire [31:0] wireIR;
wire tempMfc;


assign temp4 = 32'h00000004;

always @ (*)
begin
	IR_Out = wireIR;
	StaReg_Out = tempStaReg;
	mfc = tempMfc;
	carry = StaReg.Y[2];
end

//Components created

register_file regf(RFOut_A, RFOut_B, ALU_Out, readA, readB, write, RFen, clr, clk);

mux_4to1 MuxA (Ma_Out, Ma, RFOut_B, MDR_Out, Mb_Out, temp4);

mux_2to1 MuxB (Mb_Out, Mb, BranchExt_Out, SignExt_Out);

mux_2to1 MuxC (Mc_Out, Mc, ALU_Out, MemOut);

mux_2to1 MuxD (Md_Out, Md, Me_Out, RFOut_A);

mux_2to1 MuxE (Me_Out, Me, wireIR, wireIR);

mux_2to1_4bits MuxF (readA, Mf, readA_cu, wireIR[19:16]);

mux_4to1_4bits MuxG (readB, Mg, readB_cu, wireIR[3:0], wireIR[15:12], wireIR[19:16]);

mux_2to1_4bits MuxL (Ml_out, Ml, write_cu, wireIR[15:12]);

mux_2to1_4bits MuxO (opcode_in, Mo, cu_opcode, wireIR[24:21]);

mux_2to1_1bit MuxS (StatusRegEn, Ms, StatusRegEn_cu, ~wireIR[20]);

arm_alu alu (ALU_Out, Flags [0], Flags [1], Flags[2], Flags [3], opcode_in, RFOut_A, Shf_Out, carry);

branch_extender branchExt (BranchExt_Out, wireIR[23:0]);

Imme_Sign_Extension signExt (SignExt_Out, wireIR, SignExtEn, imme_SEL);

Sign_Extension2 signExt2 (SignExt_Out2, Mc_Out, dataType, SignExtEn2);

Shifter shift (Shf_Out, Flags [2], Ma_Out, wireIR[6:5], Md_Out, SHFen);

register_32_bits InsReg (wireIR, MemOut, IREn, clr, clk);

register_32_bits StaReg (tempStaReg, Flags, StatusRegEn, clr, clk);

register_32_bits Mar (MAR_Out, ALU_Out, MAREn, clr, clk);

register_32_bits Mdr (MDR_Out, SignExt_Out2, MDREn, clr, clk);

Ram ram (MDR_Out, MemEN, r_w, mfa, dataType, dwp, MAR_Out [7:0], tempMfc, MemOut);

endmodule
