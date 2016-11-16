//Control Unit

module control_unit(output reg [44:0] cu_out, input clk, reset, mfc, input [31:0] cu_in, input [3:0] flags);

//Wires connected to other components

wire im_out, Mh_out, enc_en, le, inv_out;
wire [1:0] next_state_out;
wire [5:0] enc_out, inc_out, Mj_out, Mk_out, incR_out;
wire [54:0] rom_out;
reg [31:0] tempIR;
parameter ONE = 6'b000001;
parameter ZERO = 6'b000000;


wire [54:0] tempPipe;
reg [5:0] nxSt;

//Components Created

PipelineRegister pipe_reg (tempPipe, rom_out, clk);

Input_Manager input_man (im_out, flags, cu_in [31:28]);

mux_2to1_1bit MuxH (Mh_out, tempPipe[15], im_out, mfc);

mux_4to1_6bits MuxJ (Mj_out, next_state_out, enc_out, ONE, tempPipe[8:3], incR_out);

mux_2to1_6bits MuxK (Mk_out, reset, ZERO, Mj_out);

encoder enc (enc_out, tempIR, clk);

Microstore_ROM rom (rom_out, Mk_out);

incrementer inc (inc_out, Mk_out);

IncrementerRegister incReg (incR_out, inc_out, clk);

Nxt_St_Sel next_state (next_state_out [0], next_state_out [1], inv_out, tempPipe[2:0]);

Inverter inverter (inv_out, Mh_out, tempPipe[54]);



always @ (*)
begin	
	cu_out <= tempPipe[53:9];
	tempIR <= cu_in;	
end

endmodule
