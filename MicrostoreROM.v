//--------------------------------------------------------------------
//					MICROSTORE (ROM)
//--------------------------------------------------------------------

module Microstore_ROM (output reg[54:0] out, input [5:0] index);

initial begin
	//index =  6'b000001;
end

always @(index)
begin
	case(index)
		6'b000000:  out = 55'b0100000000000001101001101010000010011000111100000001010;
		6'b000001:  out = 55'b0110000111111111101001101010010000011000101100000010011;
		6'b000010:  out = 55'b0011111111111110100111101010000000001000111100000010011;
		6'b000011:  out = 55'b1111111111111111101111101010000000001001010100000011101;
		6'b000100:  out = 55'b0111111111111111101111101010000000001000111100000001000;
		6'b000101:  out = 55'b0010000000000000000001011010010111011000111100000001001;
		6'b000110:  out = 55'b0010000000000000000101011110010111011000111100000001001;
		6'b000111:  out = 55'b0010000000000000000101011100110111011000111100000001001;
		6'b001000:  out = 55'b1110000000000001101011101010010110000001110101001000101;
		6'b001001:  out = 55'b0010000000000001101011101000010110011000111101000001001;
		6'b001010:  out = 55'b0110000000000001101001101000011010011000110101001011011;
		6'b001011:  out = 55'b1110000000000001101001101000011010100011111101001011111;
		6'b001100:  out = 55'b0110000000000000100101100100010110011000101101001010010;
		6'b001101:  out = 55'b0110000000000000100001101000010110011000101101001010010;
		6'b001110:  out = 55'b0010000000000000100101101000010110011000101101001010010;
		6'b001111:  out = 55'b0010000000000000100001101000010110011000101101001010010;
		6'b010000:  out = 55'b0110000000000001101001101000010110011000101101010001011;
		6'b010001:  out = 55'b0010000000000000100101101000010110011000111101001010010;
		6'b010010:  out = 55'b0110000000000001101001101000010110011000101101010011011;
		6'b010011:  out = 55'b0010000000000000100001101000010110011000111101001010010;
		6'b010100:  out = 55'b0110000000000000100101100100010110011000101101001000010;
		6'b010101:  out = 55'b0110000000000000100001101000010110011000101101001000010;
		6'b010110:  out = 55'b0010000000000000100101101000010110011000101101001000010;
		6'b010111:  out = 55'b0010000000000000100001101000010110011000101101001000010;
		6'b011000:  out = 55'b0110000000000001101001101000010110011000101101011001011;
		6'b011001:  out = 55'b0010000000000000100101101000010110011000111101001000010;
		6'b011010:  out = 55'b0110000000000001101001101000010110011000101101011011011;
		6'b011011:  out = 55'b0010000000000000100001101000010110011000111101001000010;
		6'b011100:  out = 55'b1110000000000001101001101010010110000001110011011100101;
		6'b011101:  out = 55'b0010000000000001101011101000010110011000111111000001001;
		6'b011110:  out = 55'b0110000000000001101001101000011010011000110011011111011;
		6'b011111:  out = 55'b1110000000000001101001101000011010100000111111011111111;
		6'b100000:  out = 55'b0011111111111110100101101000000000011000111110000001001;
		6'b100001:  out = 55'b0011110111111111101001101000000000011000111110100010011;
		6'b100010:  out = 55'b0011111111111110100101101100000000011000111110000001001;
		6'b100011:  out = 55'b0110000000000000100101100000010110011000101111011110010;
		6'b100100:  out = 55'b0010000000000000100101101000010110011000101111011110010;
		6'b100101:  out = 55'b0110000000000001101001101000010110011000101111100110011;
		6'b100110:  out = 55'b0010000000000000100101101000010110011000111111011110010;
		6'b100111:  out = 55'b0110000000000000100101100000010110011000101111011100010;
		6'b101000:  out = 55'b0010000000000000100101101000010110011000101111011100010;
		6'b101001:  out = 55'b0110000000000001101001101000010110011000101111101001011;
		6'b101010:  out = 55'b0010000000000000100101101000010110011000111111011100010;
		6'b101011:  out = 55'b0110000000000001101001101000010110011000111111100000111;
		6'b101100:  out = 55'b0110000000000001101001101000010110011000111111100001111;
	endcase
end

endmodule
