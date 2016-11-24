// Sign Extension for Memory Data

module Sign_Extension2 (output reg [31:0] Y, input [31:0] in, input [1:0] dataType, input enable);
   
always @ (in, dataType)

begin
   if (!enable)
      case(dataType)
		    2'b00: // Byte
			   begin 
				  assign Y[7:0] = in[7:0];
				  assign Y[31:8] = {24{in[7]}};
			   end
   		2'b01: // Halfword
   			begin
   				assign Y[15:0] = in[15:0];
   				assign Y[31:16] = {16{in[15]}};
   			end
   		2'b10: // Word
   			begin
   				assign Y = in;
   			end
   		2'b11: // Doubleword
   			begin
   				assign Y = in;
   			end
      endcase
   else
      assign Y = in;
end

endmodule