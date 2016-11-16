// Inverter
// Takes input and negates it, depending on control signal INV
module Inverter (output reg out, input in, INV);

always @(*)
begin
	if(INV == 1'b0)
		out = in;
	else
		out = ~in;
end

endmodule