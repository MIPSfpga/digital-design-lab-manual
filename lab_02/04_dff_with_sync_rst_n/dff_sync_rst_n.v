module dff_sync_rst_n
(
	input d,
	input clk,
	input rst_n,
	output reg q
);

	always @ (posedge clk)
		if (!rst_n)
			q <= 0;
		else
			q <= d;
 
endmodule
