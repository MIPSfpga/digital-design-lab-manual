module pow_5_en_multi_cycle_always
# (
    parameter w = 8
)
(
    input            clk,
    input            rst_n,
    input            clk_en,
    input            arg_vld,
    input  [w - 1:0] n,
    output           res_vld,
    output [w - 1:0] res
);

    reg           arg_vld_q;
    reg [w - 1:0] n_q;

    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            arg_vld_q <= 1'b0;
        else if (clk_en)
            arg_vld_q <= arg_vld;
    
    always @ (posedge clk)
        if (clk_en)
            n_q <= n;

    reg [4:0] shift;

    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
        begin
            shift <= 5'b0;
        end
        else if (clk_en)
        begin
            if (arg_vld_q)
                shift <= 5'b10000;
            else
                shift <= shift >> 1;
        end

    assign res_vld = shift [0];

    reg [w - 1:0] mul;

    always @(posedge clk)
        if (clk_en)
        begin
            if (arg_vld_q)
                mul <= n_q;
            else
                mul <= mul * n_q;
        end

    assign res = mul;

endmodule
