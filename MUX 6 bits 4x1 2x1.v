//Multiplexer 6 bits 4 to 1

module mux_4to1_6bits (output reg [5:0] Y, input [1:0] S,
		 input [5:0] D0, input [5:0] D1, input [5:0] D2, input [5:0] D3);

always @ (S,D0,D1,D2,D3)

case (S)

2'b00:   Y = D0;
2'b01:   Y = D1;
2'b10:   Y = D2;
2'b11:   Y = D3;

endcase

endmodule

//Multiplexer 6 bits 2 to 1

module mux_2to1_6bits (output reg [5:0] Y, input S,
		 input [5:0] D0, input [5:0] D1);

always @ (S,D0,D1)

case (S)

1'b0:   Y = D0;
1'b1:   Y = D1;

endcase

endmodule
