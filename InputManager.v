//-----------------------------------------------------------------
//					INPUT Signals MANAGER
//-----------------------------------------------------------------

module Input_Manager (output reg out, input [3:0] Flags, cond_Code);

/*
Flags[0] = Negative Flag
Flags[1] = Zero Flag
Flags[2] = Carry Flag
Flags[3] = Overflow Flag
*/
always @ (*)
begin
	
	case (cond_Code)
	//EQ
	4'b0000: 
	begin
		out = Flags[1];
	end 
	
	//NE
	4'b0001:
	begin
		out = ~Flags[1];
	end 
	
	//CS/HS
	4'b0010:
	begin
		out = Flags[2];
	end 
	
	//CC/LO
	4'b0011: 
	begin
		out = ~Flags[2];
	end 
	
	//MI
	4'b0100:
	begin
		out = Flags[0];
	end 
	
	//PL
	4'b0101:
	begin
		out = ~Flags[0];
	end 
	
	//VS
	4'b0110:
	begin
		out = Flags[3];
	end 
	
	//VC
	4'b0111:
	begin
		out = ~Flags[3];
	end 
	
	//HI
	4'b1000:
	begin
		out = Flags[2] & ~Flags[1];
	end 
	
	//LS
	4'b1001:
	begin
		out = ~Flags[2] | Flags[1];
	end 
	
	//GE
	4'b1010:
	begin
		out = ~(Flags[0] ^ Flags[3]);
	end 
	
	//LT
	4'b1011:
	begin
		out = Flags[0] ^ Flags[3];
	end 
	
	//GT
	4'b1100:
	begin
		out = ~(Flags[0] ^ Flags[3]) & (~Flags[1]);
	end 
	
	//LE
	4'b1101:
	begin
		out = (Flags[0] ^ Flags[3]) | (Flags[1]);
	end 
	
	//AL
	4'b1110:
	begin
		out = 1'b1;
	end 
	
	//**NOT USED**
	4'b1111:
	begin
	end 
	
	endcase
end 

endmodule