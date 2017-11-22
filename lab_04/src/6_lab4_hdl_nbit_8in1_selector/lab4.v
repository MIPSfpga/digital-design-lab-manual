module bn_select_8_1_case
#(parameter DATA_WIDTH=8)
(
    input       [DATA_WIDTH-1:0] d0, 
	input       [DATA_WIDTH-1:0] d1,
	input       [DATA_WIDTH-1:0] d2,
	input       [DATA_WIDTH-1:0] d3,
	input       [DATA_WIDTH-1:0] d4, 
	input       [DATA_WIDTH-1:0] d5,
	input       [DATA_WIDTH-1:0] d6,
	input       [DATA_WIDTH-1:0] d7,
	input       [7:0] sel,
    output  reg [DATA_WIDTH-1:0] y
);
	
	 always @(*)
		 case (sel)
			 8'b00000001: y=d0;
			 8'b00000010: y=d1;
			 8'b00000100: y=d2;
			 8'b00001000: y=d3;
			 8'b00010000: y=d4;
			 8'b00100000: y=d5;
			 8'b01000000: y=d6;
			 8'b10000000: y=d7;
			 default:     y={DATA_WIDTH{1'bz}};
		 endcase
		 
endmodule

module lab4
(
    input   [ 1:0]  KEY,
    input   [ 9:0]  SW,
    output  [ 9:0]  LEDR
);

	bn_select_8_1_case #(2) bn_select_8_1_case (.d0(KEY[1:0]), .d1(KEY[1:0]), .d2(KEY[1:0]), 
	                                            .d3(KEY[1:0]), .d4(KEY[1:0]), .d5(KEY[1:0]), 
												.d6(KEY[1:0]), .d7(KEY[1:0]), .sel(SW[7:0]), .y(LEDR[1:0]));
endmodule