module pow_5_multi_cycle_always
# (
    parameter w = 8
)
(
    input            clk,
    input            rst_n,
    input            arg_vld,
    input  [w - 1:0] arg,
    output           res_vld,
    output [w - 1:0] res
);

    reg           arg_vld_q;
    reg [w - 1:0] arg_q;

    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            arg_vld_q <= 1'b0;
        else
            arg_vld_q <= arg_vld;
    
    always @ (posedge clk)
        arg_q <= arg;

    reg [4:0] shift;

    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            shift <= 5'b0;
        else if (arg_vld_q)
            shift <= 5'b10000;
        else
            shift <= shift >> 1;

    assign res_vld = shift [0];

    reg [w - 1:0] mul;

    always @(posedge clk)
        if (arg_vld_q)
            mul <= arg_q;
        else
            mul <= mul * arg_q;

    assign res = mul;

endmodule
