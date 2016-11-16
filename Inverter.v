//-------------------------------------------------------------
//					INVERTER
//-------------------------------------------------------------

module Inverter (output reg out, input in, invtr);

always @(*)
begin
	if(invtr == 1'b0)
		out = in;
	else
		out = ~in;
end

endmodule