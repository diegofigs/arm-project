//Incrementer

module incrementer (output reg [5:0] inc_out, input [5:0] inc_in);


initial inc_out = 6'b000000;

always @ (*)
	inc_out = inc_in + 1'b1;

endmodule
