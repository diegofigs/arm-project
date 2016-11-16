//RAM 256 

module Ram (
input [31:0] data_in   , 
input enable,
input r_w , 
input mfa,
input [1:0] dtype,
input _dwp1, 
input [7:0] addr,
output reg mfc,
output reg [31:0] data_out         
);




reg [7:0] ram[0:255];

reg [7:0] t_addr;

// constants
   parameter BYTE = 2'b00;
   parameter HALF = 2'b01;
   parameter WORD = 2'b10;
   parameter DWORD = 2'b11;
   parameter WRITE = 1'b1;
   parameter READ = 1'b0;
   parameter ENABLE = 1'b0;
   


always@(mfa)
begin
	if(enable == 0) begin
	case(dtype)
		BYTE:begin
			if(r_w==WRITE)begin
				ram[addr] <= data_in[7:0];
			end
			
				data_out <= {{24{1'b0}}, ram[addr]};
		end
		HALF:begin
			t_addr[7:1] <= addr[7:1];
			t_addr[0] <= 1'b0;
			#5;
			if(r_w==WRITE)begin
				ram[addr] <= data_in[15:8];
				ram[addr+1] <= data_in[7:0];
				#3;
			end
			
				data_out <= {{16{1'b0}}, ram[addr], ram[addr+1] };
			#3;
		end
		WORD:begin
			t_addr[7:2] <= addr[7:2];
			t_addr[1:0] <= 2'b00;
			#1;
			
			if(r_w==WRITE)begin
				ram[t_addr] <= data_in[31:24];
				ram[t_addr+1] <= data_in[23:16];
				ram[t_addr+2] <= data_in[15:8];
				ram[t_addr+3] <= data_in[7:0];
				#1;
			end 
			
			data_out[31:24] <= ram[t_addr];
			data_out[23:16] <= ram[t_addr+1];
			data_out[15:8] <= ram[t_addr+2];
			data_out[7:0] <= ram[t_addr+3];
			#1;
		end
		DWORD:begin
			t_addr[7:3] <= addr[7:3];
			t_addr[2:0] <= 3'b000;
			#5;
			 
			if(r_w==WRITE)
				begin
					if(_dwp1)
						begin
							ram[t_addr] <= data_in[31:24];
							ram[t_addr+1] <= data_in[23:16];
							ram[t_addr+2] <= data_in[15:8];
							ram[t_addr+3] <= data_in[7:0];
						end
					else
						begin
							ram[t_addr+4] <= data_in[31:24];
							ram[t_addr+5] <= data_in[23:16];
							ram[t_addr+6] <= data_in[15:8];
							ram[t_addr+7] <= data_in[7:0];
						end
				#3;
			end 
			
			if(_dwp1)
				begin
					data_out[31:24] <= ram[t_addr];
					data_out[23:16] <= ram[t_addr+1];
					data_out[15:8] <= ram[t_addr+2];
					data_out[7:0] <= ram[t_addr+3];
				end
			else
				begin
					data_out[31:24] <= ram[t_addr+4];
					data_out[23:16] <= ram[t_addr+5];
					data_out[15:8] <= ram[t_addr+6];
					data_out[7:0] <= ram[t_addr+7];
				end
			#3;
		end
	endcase
	
	#5 mfc <= 1'b1;
	end
end

always@(mfa)
begin
	if (mfa == 1'b1)
		mfc <= 1'b0;
end

endmodule





