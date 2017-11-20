module dff_sync_rst_n_parameterized
(
	d,
	clk,
	rst_n,
	q
);
	parameter BUS_WIDTH = 1;    // DFF width
    input [BUS_WIDTH - 1:0] d;
	input clk;
	input rst_n;
    output [BUS_WIDTH - 1:0] q;
    reg [BUS_WIDTH - 1:0] q;

	always @ (posedge clk)
		if (!rst_n)
			q <= 0;
		else
			q <= d;
 
endmodule
