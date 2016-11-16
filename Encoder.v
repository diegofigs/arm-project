//Encoder

module encoder (output reg [5:0] out, input [31:0] in, input clk);

reg [31:0] temp;

initial begin
	assign temp = in;
end

always @ (in)
begin
	case (temp[27:25])

		3'b000:

			begin

				if (temp[4] == 1'b0)

					begin

						if (temp[11:7] == 5'b00000)

							out = 6'b000101; //5 = Register Shifter Operand

						else

						out = 6'b000111; //7 = Shift by Immediate Shifter Operand

					end

				if (temp[4] == 1'b1)

					begin

						if (temp[24] == 1'b0)

							begin

								if(temp[20] == 1'b1)

									begin

										out = 6'b101001; //41 = Immediate Post-Indexed Load MISCELLANEOUS

									end

								else

										out = 6'b100101; //37 = Immediate Post-Indexed Store MISCELLANEOUS
							end

						else
							
							begin

								case (temp[21])

									1'b0: 

										begin 

											if(temp[20] == 1'b1)

												begin

													out = 6'b100111; //39 = Immediate Offset Load MISCELLANEOUS

												end

											else

													out = 6'b100011; //35 = Immediate Offset Store MISCELLANEOUS
										
										end

									1'b1: 

										begin 

											if(temp[20] == 1'b1)

												begin

													out = 6'b101000; //40 = Immediate Pre-Indexed Load MISCELLANEOUS

												end

											else

													out = 6'b100100; //36 = Immediate Pre-Indexed Store MISCELLANEOUS
										end

								endcase

							end

					end

			end

		3'b001:

			out = 6'b000110; //6 = 32-bit Immediate Shifter Operand

		3'b010:

			begin

				if (temp[24] == 1'b0)

					begin
						
						if(temp[20] == 1'b1)

							begin

								out = 6'b011000; //24 = Immediate Post-Indexed Load

							end

						else

								out = 6'b010000; //16 = Immediate Post-Indexed Store
					
					end

				else

					begin

						case (temp[21])

							1'b0: 
								
								begin
									
									if(temp[20] == 1'b1)

										begin

											out = 6'b010100; //20 = Immediate Offset Load

										end

									else

											out = 6'b001100; //12 = Immediate Offset Store
								
								end

							1'b1: 
								
								begin

									if(temp[20] == 1'b1)

										begin

											out = 6'b010110; //22 = Immediate Pre-Indexed Load

										end

									else

											out = 6'b001110; //14 = Immediate Pre-Indexed Store
								
								end

						endcase

					end
			end

		3'b011:

			begin

				if (temp[24] == 1'b0)

					begin

						if(temp[20] == 1'b1)

							begin

								out = 6'b011010; //26 = Register Post-Indexed Load

							end

						else

								out = 6'b010010; //18 = Register Post-Indexed Store
					
					end

				else

					begin

						case (temp[21])

							1'b0: 
								
								begin 

									if(temp[20] == 1'b1)

										begin

											out = 6'b010101; //21 = Register Offset Load

										end

									else

											out = 6'b001101; //13 = Register Offset Store

								end
							
							1'b1: 

								begin

									if(temp[20] == 1'b1)

										begin

											out = 6'b010111; //23 = Register Pre-Indexed Load

										end

									else

											out = 6'b001111; //15 = Register Pre-Indexed Store
								end

						endcase

					end

			end

		3'b101:

			begin

				if (temp[24] == 1'b0)

					begin

						out = 6'b101011; //43 = Branch

					end

				else

					begin

						out	= 6'b101100; //44 = Branch with Link

					end

			end

	endcase

	begin
	if (temp == 31'h00000000)
		out=6'b000000;
	end
end

endmodule
