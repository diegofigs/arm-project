// Incrementer
// Provides a serial number that auto increments on each time tick.
module incrementer (output reg [5:0] inc_out, input [5:0] inc_in);

// Set count to 0 by default
initial inc_out = 6'b000000;

always @ (*)
	inc_out = inc_in + 1'b1; // bit increment
endmodule
