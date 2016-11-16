//Multiplexer 1 bit 2 to 1

module mux_2to1_1bit (output reg Y, input S,
		 input D0, input D1);

always @ (S,D0,D1)

case (S)

1'b0:   Y = D0;
1'b1:   Y = D1;

endcase

endmodule
