//Incrementer Register

module IncrementerRegister (output reg [5:0] out, input [5:0] in, input clk);

always @(posedge clk)	
    out <= in;	

endmodule
