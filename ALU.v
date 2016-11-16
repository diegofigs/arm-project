/*ALU*/
module arm_alu(output reg [31:0] result, output reg N, Z, C, V, input [3:0] opcode, input [31:0] A, B, input carry);
	
	always @ (A, B, carry, opcode)
		begin
			case(opcode)
				4'b0000: // AND - Logical AND
					begin
						result = A & B;
					end
				4'b0001: // EOR - Logical EOR
					begin
						result = A ^ B;
						C = carry;
					end
				4'b0010: // SUB - Substract
					begin
						{C,result} = A - B;
						C = ~C;
						update_SUB_V_Flag();
					end
				4'b0011: //RSB - Reverse Subtract
					begin
						{C,result} = B - A;
						C = ~C;
						update_RSB_V_Flag();
					end
				4'b0100: // ADD - Addition
					begin
						{C,result} = A + B;
						update_ADD_V_Flag();
					end
				4'b0101: // ADC - Addition with Carry
					begin
						{C,result} = A + B + C;
						update_ADD_V_Flag();
					end
				4'b0110: // SBC - Subtract with Carry
					begin
						C = ~C;
						{C,result} = A - B - C;
						C = ~C;
						update_SUB_V_Flag();
					end
				4'b0111: //RSC - Reverse Subtract with Carry
					begin
						C = ~C;
						{C,result} = B - A - C;
						C = ~C;
						update_RSB_V_Flag();
					end
				4'b1000: //TST - Test (Logical AND, with no results written)
					begin
						result = A & B;
						C = carry;
					end
				4'b1001: //TEQ - Test Equivalence (Logical EOR, with no results written)
					begin
						result = A ^ B;
						C = carry;
					end
				4'b1010: //CMP - Compare (SUB, with no results written)
					begin
						{C,result} = A - B;
						C = ~C;
						update_SUB_V_Flag();
					end
				4'b1011: //CMN - Compare Negated (NOT ADD, with no results written)
					begin
						{C,result} = A + B;
						update_ADD_V_Flag();
					end
				4'b1100: // ORR - Logical OR
					begin
						result = A | B;
						C = carry;
					end
				4'b1101: //MOV - Move
					begin
						result = B;
						C = carry;
					end
				4'b1110: //BIC - Bit Clear
					begin
						result = A & ~B;
						C = carry;
					end
				4'b1111: //MVN - Move Not
					begin
						result = ~B;
						C = carry;
					end
			endcase

			N = result[31]; // Set Negative (N) Flag to the result's most significant bit
			if(result == 0) Z = 1; // Set Zero (Z) Flag
			else Z = 0;
		end

		task update_ADD_V_Flag; // Check for Overflow when adding
		begin
			if((A[31] == 0 && B[31] == 0 && result[31] == 1) || (A[31] == 1 && B[31] == 1 && result[31] == 0))
				V=1;
			else 
				V=0;
		end
		endtask
		
		task update_SUB_V_Flag; // Check for overflow when substracting
		begin
			if((A[31] == 0 && B[31] == 1 && result[31] == 1) || (A[31] == 1 && B[31] == 0 && result[31] == 0))
				V=1;
			else 
				V=0;
		end
		endtask
		
		task update_RSB_V_Flag; // Check for overflow when reverse substracting
		begin
			if((B[31] == 0 && A[31] == 1 && result[31] == 1) || (B[31] == 1 && A[31] == 0 && result[31] == 0))
				V=1;
			else 
				V=0;
		end
		endtask
		
endmodule