//Register of 32 bits

module register_32_bits (output reg [31:0] Y, input [31:0] I,
			 input LE, CLR, CLK);

always @ (posedge CLK, negedge CLR)

if (!CLR) 
   
    Y <= 32'h00000000; //Clear es active low, 0 = clear y 1 = no esta clear

else if ((LE == 0) && (CLK == 1)) 
          
    Y = I;

endmodule 
