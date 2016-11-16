//---------------------------------------------------------------
//                  NEXT STATE ADDRESS SELECTOR
//---------------------------------------------------------------

module Nxt_St_Sel (output reg M0, output reg M1, input cond_S, input [2:0] pipeline);

initial begin
	M0 = 1'b1;
	M1 = 1'b0;
end


always @ (*)
case (pipeline)

	3'b000: //Encoder
	begin
		M0 = 1'b0;
		M1 = 1'b0;
	end
	
	3'b001: //Fetch
	begin
		M0 = 1'b1;
		M1 = 1'b0;
	end
	
	3'b010: //Pipeline
	begin
		M0 = 1'b0;
		M1 = 1'b1;
	end
	
	3'b011: //Incrementer 
	begin
		M0 = 1'b1;
		M1 = 1'b1;
	end
	
	3'b100:
	begin
		if(cond_S == 1'b1)
		begin
			M0 = 1'b0;
			M1 = 1'b1;
		end
		else
		begin
			M0 = 1'b0;
			M1 = 1'b0;
		end 
	end	
	
	3'b101:
	begin
		if(cond_S == 1'b1)
		begin
			M0 = 1'b0;
			M1 = 1'b1;
		end
		else
		begin
			M0 = 1'b1;
			M1 = 1'b1;
		end
	end
	
	3'b110:
	begin
		if(cond_S == 1'b1)
		begin
			M0 = 1'b0;
			M1 = 1'b0;
		end
		else
		begin
			M0 = 1'b1;
			M1 = 1'b1;
		end
	end
	
	3'b111:
	begin
		if(cond_S == 1'b1)
		begin
			M0 = 1'b0;
			M1 = 1'b1;
		end
		else
		begin
			M0 = 1'b1;
			M1 = 1'b0;
		end
	end
endcase

endmodule