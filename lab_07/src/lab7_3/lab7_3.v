module lab7_3

#(parameter DATA_WIDTH=2, parameter ADDR_WIDTH=3)
(
	input [(DATA_WIDTH-1):0] data_in,
	input [(ADDR_WIDTH-1):0] read_addr, 
	input [(ADDR_WIDTH-1):0] write_addr,
	input we, 
	input clk,
	output reg [(DATA_WIDTH-1):0] data_out
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];
	
	// invert chip select signal and clk button
    wire w_clk = ~ clk;
	
	always @ (posedge w_clk)
	begin
		// Write
		if (we)
			ram[write_addr] <= data_in;

		data_out <= ram[read_addr];
	end

endmodule
