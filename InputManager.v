// Input Signal Manager

// Flags[0] = Negative Flag
// Flags[1] = Zero Flag
// Flags[2] = Carry Flag
// Flags[3] = Overflow Flag

module Input_Manager (output reg out, input [3:0] Flags, cond_Code);


always @ (*)
begin
	
	case (cond_Code)

	4'b0000: // EQ
	begin
		out = Flags[1];
	end 

	4'b0001: // NE
	begin
		out = ~Flags[1];
	end 

	4'b0010: // CS/HS
	begin
		out = Flags[2];
	end 
	
	4'b0011: // CC/LO
	begin
		out = ~Flags[2];
	end 
	
	4'b0100: // MI
	begin
		out = Flags[0];
	end 
	
	4'b0101: // PL
	begin
		out = ~Flags[0];
	end 
	
	4'b0110: // VS
	begin
		out = Flags[3];
	end 
	
	4'b0111: // VC
	begin
		out = ~Flags[3];
	end 
	
	4'b1000: // HI
	begin
		out = Flags[2] & ~Flags[1];
	end 
	
	4'b1001: // LS
	begin
		out = ~Flags[2] | Flags[1];
	end 
	
	4'b1010: // GE
	begin
		out = ~(Flags[0] ^ Flags[3]);
	end 
	
	4'b1011: // LT
	begin
		out = Flags[0] ^ Flags[3];
	end 
	
	4'b1100: // GT
	begin
		out = ~(Flags[0] ^ Flags[3]) & (~Flags[1]);
	end 
	
	4'b1101: // LE
	begin
		out = (Flags[0] ^ Flags[3]) | (Flags[1]);
	end 
	
	4'b1110: // AL
	begin
		out = 1'b1;
	end 
	
	// Spare
	4'b1111:
	begin
	end 
	
	endcase
end 

endmodule