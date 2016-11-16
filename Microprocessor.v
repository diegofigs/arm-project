//MICROPROCESDOR ARM

module microprocessor();

wire mfc; 
wire [31:0] IR_Out, StaReg_Out; 
wire [44:0] cu_out;
reg clk, clr;

//Module Instantiation
DataPath datapath (.mfc(mfc), .IR_Out(IR_Out), .StaReg_Out(StaReg_Out), .cu_opcode(cu_out[30:27]), .write_cu(cu_out[42:39]), .readA_cu(cu_out[38:35]), .readB_cu(cu_out[34:31]), 
	.Ma(cu_out[26:25]), .dataType(cu_out[9:8]), .imme_SEL(cu_out[1:0]), .RFen(cu_out[44]), .Mb(cu_out[20]), .Mc(cu_out[19]), .Md(cu_out[18]), .Me(cu_out[17]), .Mf(cu_out[16]), 
	.Mg(cu_out[15:14]), .Mo(cu_out[12]), .Ms(cu_out[22]), .Ml(cu_out[13]), .MAREn(cu_out[4]), .MDREn(cu_out[3]), .IREn(cu_out[5]), .SHFen(cu_out[24]), .SignExtEn(cu_out[21]), 
	.SignExtEn2(cu_out[2]), .r_w(cu_out[11]), .MemEN(cu_out[10]), .dwp(cu_out[7]), .mfa(cu_out[6]), .clk(clk), .clr(clr), .StatusRegEn_cu(cu_out[23]));

control_unit cu (.cu_out(cu_out), .clk(clk), .reset(clr), .mfc(mfc), .cu_in(IR_Out), .flags(StaReg_Out [3:0]));

//Memory Variables
reg [31:0] dat[0:155];
parameter WORD = 2'b10;
parameter WRITE = 1'b1;
parameter ENABLE = 1'b0;
reg [31:0] temp_data_in;
reg [7:0] temp_addr;

initial #5000 $finish;

initial $readmemb("testcode_arm1.txt", dat);

reg [8:0] i; // loop index

initial begin
	
//----------------------------------------------------------------------
//					FILL RAM MEMORY
//----------------------------------------------------------------------
	for(i=9'h000;i<9'h030;i=i+9'h004)
	begin
		temp_data_in[31:24] <= dat[i[7:0]]; 
		temp_data_in[23:16] <= dat[i[7:0]+1]; 
		temp_data_in[15:8] <= dat[i[7:0]+2]; 
		temp_data_in[7:0] <= dat[i[7:0]+3]; //setting up data
		#5;
		datapath.ram.ram[i[7:0]] <= temp_data_in[31:24]; 
		datapath.ram.ram[i[7:0]+1]<= temp_data_in[23:16]; 
		datapath.ram.ram[i[7:0]+2] <= temp_data_in[15:8]; 
		datapath.ram.ram[i[7:0]+3] <= temp_data_in[7:0];
		#5;
	  end 
		
	for(i=9'h000;i<9'h030;i=i+9'h004)
	begin
		$write ("WORD DATA at %d: %h", i, datapath.ram.ram[i[7:0]]);
		$write ("%h", datapath.ram.ram[i[7:0]+1]);
		$write ("%h", datapath.ram.ram[i[7:0]+2] ); 
		$display ("%h", datapath.ram.ram[i[7:0]+3]);
	end
	
	clr = 1'b0;
	#5 clk = 1'b0;
	#5 clk = 1'b1;
	#5 clk = 1'b0;
	#5 clk = 1'b1;
	clr = 1'b1;
	repeat (500) #5 clk = ~clk;
	
	#10 $display("\nTesting content of Registers:\nR0 = %h\nR1 = %h\nR2 = %h\nR3 = %h\nR4 = %h\nR5 = %h\nR6 = %h\nR7 = %h\nR8 = %h\nR9 = %h\nR10 = %h\nR11 = %h\nR12 = %h\nR13 = %h\nR14 = %h\nR15 = %h\n", datapath.regf.register0.Y, datapath.regf.register1.Y, datapath.regf.register2.Y, datapath.regf.register3.Y, datapath.regf.register4.Y, datapath.regf.register5.Y, datapath.regf.register6.Y, datapath.regf.register7.Y, datapath.regf.register8.Y, datapath.regf.register9.Y, datapath.regf.register10.Y, datapath.regf.register11.Y, datapath.regf.register12.Y, datapath.regf.register13.Y, datapath.regf.register14.Y, datapath.regf.register15.Y);
	
	for(i=9'h000;i<9'h030;i=i+9'h004)
	begin
		$write ("WORD DATA at %d: %h", i, datapath.ram.ram[i[7:0]]);
		$write ("%h", datapath.ram.ram[i[7:0]+1]);
		$write ("%h", datapath.ram.ram[i[7:0]+2] ); 
		$display ("%h", datapath.ram.ram[i[7:0]+3]);
	end
	
end

initial begin

	/*$monitor("R10: %h\nR5: %h\nR3: %h\nR2: %h\nR1: %h\nR0: %h\nR15: %h\nRead A: %b\nRead B: %b\nR15 Enable: %d\nRF Enable: %d\nIR: %h\nIR Enable: %d\nMDR: %h\nMAR: %h\nMar enable: %b\nRAM out: %h\nMFC: %b\nPipeToNext: %b\nCond S: %b\nInv Out: %b\nFlags: %b\nCond Code: %b\nIM Out: %b\nM0: %b\nM1: %b\nEncode OUT: %d\nData A: %h\nData B: %h\nALU out: %h\nOpcode: %b\nMJ Out: %d\nMK Sel: %b\nMK Out: %d\nBranch In: %h\nBranch Out: %h\nMuxA Sel: %b\nMuxA Out: %h\nMuxB Out: %h\nMuxB Sel: %b\nTime: %d\nNext State: %d\n--------------------------------------", datapath.regf.register10.Y, datapath.regf.register5.Y, datapath.regf.register3.Y, datapath.regf.register2.Y, datapath.regf.register1.Y, datapath.regf.register0.Y, datapath.regf.register15.Y, datapath.regf.readA, datapath.regf.readB, datapath.regf.register15.LE, datapath.regf.enable, datapath.InsReg.Y, datapath.InsReg.LE, datapath.Mdr.Y, datapath.Mar.Y, datapath.Mar.LE, datapath.ram.data_out, datapath.ram.mfc, cu.next_state.pipeline, cu.next_state.cond_S, cu.inverter.out, cu.input_man.Flags, cu.input_man.cond_Code, cu.input_man.out, cu.next_state.M0, cu.next_state.M1, cu.enc.enc_out, datapath.regf.outA, datapath.alu.dataB, datapath.alu.result, datapath.alu.op_code, cu.MuxJ.Y, cu.MuxK.S, cu.MuxK.Y, datapath.branchExt.offset, datapath.branchExt.final_offset, datapath.MuxA.S, datapath.MuxA.Y, datapath.MuxB.Y, datapath.MuxB.S, $time, cu.rom.index);*/

	$monitor("MAR: %0d\n\n--------------\n\nState: %d", datapath.Mar.Y, cu.rom.index);
	//$monitor("MAR: %0d\n Flags (ALU): %b %b %b %b\n Flags (SR): %b\n Flags (CU): %b\n--------------\n", datapath.Mar.Y, datapath.alu.N_flag, datapath.alu.Z_flag, datapath.alu.C_flag, datapath.alu.V_flag, datapath.StaReg.Y[3:0], cu.flags);

end

endmodule
