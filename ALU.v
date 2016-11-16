/*ALU*/

module arm_alu (output reg [31:0] result, output reg N_flag, Z_flag, C_flag, V_flag, input [3:0] op_code, input [31:0] dataA, dataB, input carry);
	reg [31:0] temp;
	always @ (*)
	case (op_code)
		4'b0000: //[AND] Logical AND
			begin
				result = dataA & dataB;
				C_flag = carry;
				update_N_Z_flags();
			end
		4'b0001: //[EOR] Logical Exclusive OR
			begin
				result = (dataA & ~dataB) | (~dataA & dataB);
				C_flag = carry;
				update_N_Z_flags();
			end
		4'b0010: //[SUB] Subtract
			begin
				{C_flag, result} = dataA - dataB;
				if((dataA[31] == 0 && dataB[31] == 1 && result[31] == 1) || (dataA[31] == 1 && dataB[31] == 0 && result[31] == 0))
					V_flag = 1;
				else
					V_flag = 0;
				update_N_Z_flags();
			end
		4'b0011: //[RSB] Reverse Subtract
			begin
				{C_flag, result} = dataB - dataA;
				if((dataB[31] == 0 && dataA[31] == 1 && result[31] == 1) || (dataB[31] == 1 && dataA[31] == 0 && result[31] == 0))
					V_flag = 1;
				else
					V_flag = 0;
				update_N_Z_flags();
			end
		4'b0100: //[ADD] Add
			begin
				{C_flag, result} = dataA + dataB;
				if((dataA[31] == 0 && dataB[31] == 0 && result[31] == 1) || (dataA[31] == 1 && dataB[31] == 1 && result[31] == 0))
					V_flag = 1;
				else
					V_flag = 0;
				update_N_Z_flags();
			end
		4'b0101: //[ADC] Add with Carry
			begin
				{C_flag, result} = dataA + dataB + carry;
				if((dataA[31] == 0 && dataB[31] == 0 && result[31] == 1) || (dataA[31] == 1 && dataB[31] == 1 && result[31] == 0))
					V_flag = 1;
				else
					V_flag = 0;
				update_N_Z_flags();
			end
		4'b0110: //[SBC] Subtract with Carry
			begin
				{C_flag, result} = dataA - dataB + carry;
				if((dataA[31] == 0 && dataB[31] == 1 && result[31] == 1) || (dataA[31] == 1 && dataB[31] == 0 && result[31] == 0))
					V_flag = 1;
				else
					V_flag = 0;
				update_N_Z_flags();
			end
		4'b0111: //[RSC] Reverse Subtract with Carry
			begin
				{C_flag, result} = dataB - dataA + carry;
				if((dataB[31] == 0 && dataA[31] == 1 && result[31] == 1) || (dataB[31] == 1 && dataA[31] == 0 && result[31] == 0))
					V_flag = 1;
				else
					V_flag = 0;
				update_N_Z_flags();
			end
		4'b1000: //[TST] Test
			begin
				temp = dataA & dataB;
				C_flag = carry;
				N_flag = temp[31];
					if(temp == 0) 
						Z_flag = 1;
					else 
						Z_flag = 0;
			end
		4'b1001: //[TEQ] Test Equivalence
			begin
				temp = (dataA & ~dataB) | (~dataA & dataB);
				C_flag = carry;
				N_flag = temp[31];
					if(temp == 0) 
						Z_flag = 1;
					else 
						Z_flag = 0;
			end
		4'b1010: //[CMP] Compare
			begin
				{C_flag, temp} = dataA - dataB;
				N_flag = temp[31];
					if(temp == 0) 
						Z_flag = 1;
					else 
						Z_flag = 0;
			end
		4'b1011: //[CMN] Compare Negated
			begin
				{C_flag, temp} = dataA + dataB;
				N_flag = temp[31];
					if(temp == 0) 
						Z_flag = 1;
					else 
						Z_flag = 0;
			end
		4'b1100: //[ORR] Logical OR
			begin
				result = dataA | dataB;
				C_flag = carry;
				update_N_Z_flags();
			end
		4'b1101: //[MOV] Move
			begin
				result = dataB;
				C_flag = carry;
				update_N_Z_flags();
			end
		4'b1110: //[BIC] Bit Clear
			begin
				result = dataA & ~dataB;
				C_flag = carry;
				update_N_Z_flags();
			end
		4'b1111: //[MVN] Move Not
			begin	
				result = ~dataB;
				C_flag = carry;
				update_N_Z_flags();
			end
		/*5'b10000: //Add 4 PC
			begin
				result = dataB + 4;
			end*/
	endcase

	task update_N_Z_flags; //Update the N & Z flags
	begin
		N_flag = result[31];
			if(result == 0) 
				Z_flag = 1;
			else 
				Z_flag = 0;
	end
	endtask

endmodule





