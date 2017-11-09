/*
 * Digital Design Lab Manual
 * Lab #9
 *
 * Copyright(c) 2017 Stanislav Zhelnio 
 *
 */
 
module pmod_als
#(
    parameter CNTSIZE = 11
)
(
    input             clk,
    input             rst_n,
    output            cs,
    output            sck,
    input             sdo,
    output      [7:0] value
);
    wire [ CNTSIZE - 1:0] cnt;
    wire [ CNTSIZE - 1:0] cntNext = cnt + 1;
    register #(.SIZE(CNTSIZE)) r_counter(clk, rst_n, cntNext, cnt);

    assign sck = ~ cnt [3];
    assign cs  = ~ (cnt [8] && cnt[CNTSIZE - 1:9] == { (CNTSIZE - 10) { 1'b0 } });

    wire sampleBit = ( cs == 1'b0 && cnt [3:0] == 4'b1111 );
    wire valueDone = ( cs == 1'b1 && cnt [7:0] == 8'b0 );

    wire [15:0] shift;
    wire [15:0] shiftNext = (shift << 1) | sdo;
    register_we #(.SIZE(16)) r_shift(clk, rst_n, sampleBit, shiftNext, shift);

    wire [7:0] valueNext = shift[12:5];
    register_we #(.SIZE(8))  r_value(clk, rst_n, valueDone, valueNext, value);

endmodule
