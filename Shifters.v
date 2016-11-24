//Shifter Module
module Shifter (output reg [31:0] result, output reg C_flag, input [31:0] data, input [1:0] shift, input [31:0] shiftNum , input enable);

reg [31:0] tempNum;
reg [31:0] tempData;
reg [31:0] temp;
integer i;

always @ (data, posedge enable, shift, C_flag)

//Active-low
if (enable==1'b0)
	begin

		tempNum = shiftNum;
		tempData = data;
		temp = data;

			case(shift)

				2'b00: // LSL 
				begin
					for(i = 0; i < tempNum; i = i+1)
					begin
						C_flag = tempData[31:31];
						tempData= tempData<<1;
					end
				end

				2'b01: // LSR				
				begin
					for(i = 0; i < tempNum; i = i+1)
					begin
						C_flag = tempData[0];
						tempData= tempData>>1;
					end
				end

				2'b10: // ASR				
				begin
					for(i = 0; i < tempNum; i = i+1)
						begin
						tempData= tempData>>1;
						tempData = {data[31:31], tempData[30:0]};
						end
				end

				2'b11: // ROR				
				begin
					for(i = 0; i < tempNum; i = i+1)
						begin
						temp = tempData;
						tempData= tempData>>1;
						tempData = {temp[0:0], tempData[30:0]};
						end
				end

			endcase
	result = tempData;
	end
else begin
	result = data;
end

endmodule
