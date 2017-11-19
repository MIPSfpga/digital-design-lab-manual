module pow_5_en_pipe_struct
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

    wire           n_vld_q_1;
    wire [w - 1:0] n_q_1;

    reg_rst_n_en        i0_n_vld   (clk, rst_n, clk_en, n_vld, n_vld_q_1);
    reg_no_rst_en # (w) i0_n       (clk, clk_en, n, n_q_1);

    //------------------------------------------------------------------------

    wire [w - 1:0] mul_d_1 = n_q_1 * n_q_1;

    wire           n_vld_q_2;
    wire [w - 1:0] n_q_2;
    wire [w - 1:0] mul_q_2;

    reg_rst_n_en        i1_n_vld ( clk , rst_n  , clk_en , n_vld_q_1 , n_vld_q_2 );
    reg_no_rst_en # (w) i1_n     ( clk ,          clk_en , n_q_1     , n_q_2     );
    reg_no_rst_en # (w) i1_mul   ( clk ,          clk_en , mul_d_1   , mul_q_2   );

    assign res_vld [3]   = n_vld_q_2;
    assign res     [31:24] = mul_q_2;
    
    //------------------------------------------------------------------------

    wire [w - 1:0] mul_d_2 = mul_q_2 * n_q_2;

    wire           n_vld_q_3;
    wire [w - 1:0] n_q_3;
    wire [w - 1:0] mul_q_3;

    reg_rst_n_en        i2_n_vld ( clk , rst_n  , clk_en , n_vld_q_2 , n_vld_q_3 );
    reg_no_rst_en # (w) i2_n     ( clk ,          clk_en , n_q_2     , n_q_3     );
    reg_no_rst_en # (w) i2_mul   ( clk ,          clk_en , mul_d_2   , mul_q_3   );

    assign res_vld [2]     = n_vld_q_3;
    assign res     [23:16] = mul_q_3;

    //------------------------------------------------------------------------

    wire [w - 1:0] mul_d_3 = mul_q_3 * n_q_3;

    wire           n_vld_q_4;
    wire [w - 1:0] n_q_4;
    wire [w - 1:0] mul_q_4;

    reg_rst_n_en        i3_n_vld ( clk , rst_n  , clk_en , n_vld_q_3 , n_vld_q_4 );
    reg_no_rst_en # (w) i3_n     ( clk ,          clk_en , n_q_3     , n_q_4     );
    reg_no_rst_en # (w) i3_mul   ( clk ,          clk_en , mul_d_3   , mul_q_4   );

    assign res_vld [1]    = n_vld_q_4;
    assign res     [15:8] = mul_q_4;

    //------------------------------------------------------------------------

    wire [w - 1:0] mul_d_4 = mul_q_4 * n_q_4;

    wire           n_vld_q_5;
    wire [w - 1:0] n_q_5;
    wire [w - 1:0] mul_q_5;

    reg_rst_n_en        i4_n_vld ( clk , rst_n  , clk_en , n_vld_q_4 , n_vld_q_5 );
    reg_no_rst_en # (w) i4_n     ( clk ,          clk_en , n_q_4     , n_q_5     );
    reg_no_rst_en # (w) i4_mul   ( clk ,          clk_en , mul_d_4   , mul_q_5   );

    assign res_vld [0]   = n_vld_q_5;
    assign res     [7:0] = mul_q_5;

endmodule

//--------------------------------------------------------------------

`ifndef SIMULATION

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

    pow_5_en_pipe_struct
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

`endif
