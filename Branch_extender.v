//Branch Extender

module branch_extender(output reg [31:0] final_offset, input [23:0] offset);

reg [25:0] offset1;

always @ (*)

begin

   offset1=offset;

   offset1=offset1<<2;

   final_offset= $signed(offset1);

end

endmodule
