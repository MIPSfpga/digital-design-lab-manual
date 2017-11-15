module pow_5_en_pipe_always
# (
    parameter w = 8
)
(
    input                clk,
    input                rst_n,
    input                clk_en,
    input                n_vld,
    input  [w     - 1:0] n,
    output [        3:0] res_vld,
    output [w * 4 - 1:0] res
);

    reg [w - 1:0] n1, n2, n3, n4;
    reg [w - 1:0] pow2, pow3, pow4, pow5;
    reg n_vld_1, n_vld_2, n_vld_3, n_vld_4, n_vld_5;

    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
        begin
            n_vld_1 <= 1'b0;
            n_vld_2 <= 1'b0;
            n_vld_3 <= 1'b0;
            n_vld_4 <= 1'b0;
            n_vld_5 <= 1'b0;
        end
        else if (clk_en)
        begin
            n_vld_1 <= n_vld;
            n_vld_2 <= n_vld_1;
            n_vld_3 <= n_vld_2;
            n_vld_4 <= n_vld_3;
            n_vld_5 <= n_vld_4;
        end

    always @ (posedge clk)
        if (clk_en)
        begin
            n1 <= n;
            n2 <= n1;
            n3 <= n2;
            n4 <= n3;

            pow2 <= n1 * n1;
            pow3 <= pow2 * n2;
            pow4 <= pow3 * n3;
            pow5 <= pow4 * n4;
        end

    assign res_vld = { n_vld_2 , n_vld_3 , n_vld_4 , n_vld_5 };
    assign res     = { pow2    , pow3    , pow4    , pow5    };

endmodule

//--------------------------------------------------------------------

module top
(
    input         fast_clk,
    input         slow_clk,
    input         rst_n,
    input         fast_clk_en,
    input  [ 3:0] key,
    input  [ 7:0] sw,
    output [ 7:0] led,
    output [ 7:0] disp_en,
    output [31:0] disp,
    output [ 7:0] disp_dot
);

    wire [3:0] res_vld;

    pow_5_en_pipe_always
    # (.w (8))
    i_pow_5_en
    (
        .clk     ( fast_clk    ),
        .rst_n   ( rst_n       ),
        .clk_en  ( fast_clk_en ),
        .n_vld   ( key [0]     ),
        .n       ( sw          ),
        .res_vld ( res_vld     ),
        .res     ( disp [31:0] )
    );

    assign disp_en  =
    {
        res_vld [3], res_vld [3],
        res_vld [2], res_vld [2],
        res_vld [1], res_vld [1],
        res_vld [0], res_vld [0]
    };

    assign disp_dot = 8'b0;

endmodule
