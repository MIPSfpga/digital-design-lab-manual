module lab7_1

#(parameter DATA_WIDTH=6, parameter ADDR_WIDTH=4)

(
	input [(DATA_WIDTH-1):0] data_in,
	input [(ADDR_WIDTH-1):0] addr,
	input we, clk,
	output [(DATA_WIDTH-1):0] data_out,
	output [(ADDR_WIDTH-1):0] addr_out
);


	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	reg [ADDR_WIDTH-1:0] addr_reg;

   wire w_we = ~ we;
   wire w_clk = ~ clk;

	
	always @ (posedge w_clk)
	begin
		if (w_we)
			ram[addr] <= data_in;

		addr_reg <= addr;
	end


	assign data_out = ram[addr_reg];
   assign addr_out = addr_reg;

endmodule
