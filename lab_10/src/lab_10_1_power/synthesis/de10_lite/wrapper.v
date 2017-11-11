module wrapper
(
    input           ADC_CLK_10,
    input           MAX10_CLK1_50,
    input           MAX10_CLK2_50,

    input  [  1:0 ] KEY,
    input  [  9:0 ] SW,

    output [  9:0 ] LEDR,

    output [  7:0 ] HEX0,
    output [  7:0 ] HEX1,
    output [  7:0 ] HEX2,
    output [  7:0 ] HEX3,
    output [  7:0 ] HEX4,
    output [  7:0 ] HEX5,

    inout  [ 35:0 ] GPIO
);

    wire [31:0] disp;

    top i_top
    (
        .clock   ( MAX10_CLK1_50         ),
        .reset_n ( SW [9]                ),
        
        .key     ( { 2'b0, KEY  [ 1:0] } ),
        .sw      (         SW   [ 7:0]   ),
        .led     (         LEDR [ 7:0]   ),
        .disp    (         disp [31:0]   ),
        .gpio    (         gpio [35:0]   )
    );

    wire unused =   ADC_CLK_10
                  & MAX10_CLK2_50
                  & SW [8]
                  & (GPIO == 36'b0);

    assign HEX0 [7] = 1'b1;
    assign HEX1 [7] = 1'b1;
    assign HEX2 [7] = 1'b1;
    assign HEX3 [7] = 1'b1;
    assign HEX4 [7] = 1'b1;
    assign HEX5 [7] = 1'b1;

    hex_display_digit i_digit_5 ( disp [23:20] , HEX5 [6:0] );
    hex_display_digit i_digit_4 ( disp [19:16] , HEX4 [6:0] );
    hex_display_digit i_digit_3 ( disp [15:12] , HEX3 [6:0] );
    hex_display_digit i_digit_2 ( disp [11: 8] , HEX2 [6:0] );
    hex_display_digit i_digit_1 ( disp [ 7: 4] , HEX1 [6:0] );
    hex_display_digit i_digit_0 ( disp [ 3: 0] , HEX0 [6:0] );

endmodule
