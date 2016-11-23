// Incrementer Register
// Takes care of saving temporarily the status of the incrementer.
module IncrementerRegister (output reg [5:0] out, input [5:0] in, input clk);

always @(posedge clk)	
    out <= in;
endmodule
