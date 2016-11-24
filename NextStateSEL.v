// NEXT STATE ADDRESS SELECTOR
module Nxt_St_Sel (output reg m0, output reg m1, input condS, input [2:0] pipeline);

initial begin
	m0 = 1'b1;
	m1 = 1'b0;
end

always @ (*)
case (pipeline)

	3'b000: // Encoder
	begin
		m0 = 1'b0;
		m1 = 1'b0;
	end
	
	3'b001: // Fetch
	begin
		m0 = 1'b1;
		m1 = 1'b0;
	end
	
	3'b010: // Pipeline
	begin
		m0 = 1'b0;
		m1 = 1'b1;
	end
	
	3'b011: // Incrementer 
	begin
		m0 = 1'b1;
		m1 = 1'b1;
	end
	
	3'b100:
	begin
		if(condS == 1'b1)
		begin
			m0 = 1'b0;
			m1 = 1'b1;
		end
		else
		begin
			m0 = 1'b0;
			m1 = 1'b0;
		end 
	end	
	
	3'b101:
	begin
		if(condS == 1'b1)
		begin
			m0 = 1'b0;
			m1 = 1'b1;
		end
		else
		begin
			m0 = 1'b1;
			m1 = 1'b1;
		end
	end
	
	3'b110:
	begin
		if(condS == 1'b1)
		begin
			m0 = 1'b0;
			m1 = 1'b0;
		end
		else
		begin
			m0 = 1'b1;
			m1 = 1'b1;
		end
	end
	
	3'b111:
	begin
		if(condS == 1'b1)
		begin
			m0 = 1'b0;
			m1 = 1'b1;
		end
		else
		begin
			m0 = 1'b1;
			m1 = 1'b0;
		end
	end
endcase

endmodule