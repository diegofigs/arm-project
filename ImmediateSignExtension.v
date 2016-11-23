// Sign Extension

module Imme_Sign_Extension (output reg [31:0] Y, input [31:0] in, input enable, input [1:0] immeSEL);

always @ (*)

begin
	if (!enable)
	begin
		case (immeSEL)
			2'b00:
			begin
				Y[7:0] = in[7:0];
				Y[31:8] = {24{in[7]}};
			end
			2'b01:
			begin
				Y[11:0] = in[11:0];
				Y[31:12] = {20{in[7]}};
			end
			2'b10:
			begin
				Y[23:0] = in[23:0];
				Y[31:24] = {8{in[7]}};
			end
			2'b11:
			begin
				Y[7:0] = {in[11:8], in[3:0]};
				Y[31:8] = {24{in[7]}};
			end
		endcase
	end
	
	else
	begin
		case (immeSEL)
			2'b00:
			begin
				Y[7:0] = in[7:0];
				Y[31:8] = 24'b000000000000000000000000;
			end
			2'b01:
			begin
				Y[11:0] = in[11:0];
				Y[31:12] = 20'b00000000000000000000;
			end
			2'b10:
			begin
				Y[23:0] = in[23:0];
				Y[31:24] = 8'b00000000;
			end
			2'b11:
			begin
				Y[7:0] = {in[11:8], in[3:0]};
				Y[31:8] = 24'b000000000000000000000000;
			end
		endcase
	end
end	

endmodule