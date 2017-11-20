module dff_with_en
(
	input d,
	input clk,
	input en,
	output reg q
);

	always @ (posedge clk)
		if (en)
			q <= d;
 
endmodule