// Sign Extension for Memory Data

module Sign_Extension2 (output reg [31:0] Y, input [31:0] In, input [1:0] Data_Type, input enable);

   
   always @ (In, Data_Type)

      if (!enable)

         begin

            case(Data_Type)

      		    2'b00: //Byte

      			   begin 

      				  assign Y[7:0] = In[7:0];
      				  assign Y[31:8] = {24{In[7]}};

      			   end

         		2'b01: //Halfword

         			begin

         				assign Y[15:0] = In[15:0];
         				assign Y[31:16] = {16{In[15]}};

         			end

         		2'b10: //Word

         			begin

         				assign Y = In;

         			end


         		2'b11: //Doubleword

         			begin

         				assign Y = In;

         			end
            endcase

         end

      else

         assign Y = In;

endmodule