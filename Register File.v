// Register File
// Controls 16 highly available 32-bit registers
module register_file (output reg [31:0] PA, PB, input [31:0] in, input [3:0] SA, SB, C, input enable, clr, clk);

reg decoder_enable;

wire [31:0] temp;
wire [31:0] temp1;
wire [15:0] decoder_out;
wire [31:0] register_out0, register_out1, register_out2, register_out3, register_out4, register_out5, register_out6, register_out7,
            register_out8, register_out9, register_out10, register_out11, register_out12, register_out13, register_out14, register_out15;

always @ (enable)
begin 
	
    if(!enable)
      
       begin
      
           decoder_enable = 1'b1;
       
       end
    
    else
	       
        begin

           decoder_enable = 1'b0;

        end

end

always @ (*)
begin
	PA = temp;
	PB = temp1;
end
     

decoder dec (decoder_out, C, decoder_enable);

register_32_bits register0 (register_out0, in, ~decoder_out[0], clr, clk);
register_32_bits register1 (register_out1, in, ~decoder_out[1], clr, clk);
register_32_bits register2 (register_out2, in, ~decoder_out[2], clr, clk);
register_32_bits register3 (register_out3, in, ~decoder_out[3], clr, clk);
register_32_bits register4 (register_out4, in, ~decoder_out[4], clr, clk);
register_32_bits register5 (register_out5, in, ~decoder_out[5], clr, clk);
register_32_bits register6 (register_out6, in, ~decoder_out[6], clr, clk);
register_32_bits register7 (register_out7, in, ~decoder_out[7], clr, clk);
register_32_bits register8 (register_out8, in, ~decoder_out[8], clr, clk);
register_32_bits register9 (register_out9, in, ~decoder_out[9], clr, clk);
register_32_bits register10 (register_out10, in, ~decoder_out[10], clr, clk);
register_32_bits register11 (register_out11, in, ~decoder_out[11], clr, clk);
register_32_bits register12 (register_out12, in, ~decoder_out[12], clr, clk);
register_32_bits register13 (register_out13, in, ~decoder_out[13], clr, clk);
register_32_bits register14 (register_out14, in, ~decoder_out[14], clr, clk);
register_32_bits register15 (register_out15, in, ~decoder_out[15], clr, clk);





mux_16to1 muxA (temp, SA, register_out0, register_out1, register_out2, register_out3, register_out4, register_out5, register_out6, register_out7,
               register_out8, register_out9, register_out10, register_out11, register_out12, register_out13, register_out14, register_out15);

mux_16to1 muxB (temp1, SB, register_out0, register_out1, register_out2, register_out3, register_out4, register_out5, register_out6, register_out7,
               register_out8, register_out9, register_out10, register_out11, register_out12, register_out13, register_out14, register_out15);

endmodule
