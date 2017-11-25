module pow_5_pipe_struct
# (
    parameter w = 8
)
(
    input                clk,
    input                rst_n,
    input                arg_vld,
    input  [w     - 1:0] n,
    output [        3:0] res_vld,
    output [w * 4 - 1:0] res
);

    wire           arg_vld_q_1;
    wire [w - 1:0] n_q_1;

    reg_rst_n        i0_arg_vld   (clk, rst_n, arg_vld, arg_vld_q_1);
    reg_no_rst # (w) i0_n       (clk, n, n_q_1);

    //------------------------------------------------------------------------

    wire [w - 1:0] mul_d_1 = n_q_1 * n_q_1;

    wire           arg_vld_q_2;
    wire [w - 1:0] n_q_2;
    wire [w - 1:0] mul_q_2;

    reg_rst_n        i1_arg_vld ( clk , rst_n  , arg_vld_q_1 , arg_vld_q_2 );
    reg_no_rst # (w) i1_n     ( clk ,          n_q_1     , n_q_2     );
    reg_no_rst # (w) i1_mul   ( clk ,          mul_d_1   , mul_q_2   );

    assign res_vld [3]   = arg_vld_q_2;
    assign res     [31:24] = mul_q_2;
    
    //------------------------------------------------------------------------

    wire [w - 1:0] mul_d_2 = mul_q_2 * n_q_2;

    wire           arg_vld_q_3;
    wire [w - 1:0] n_q_3;
    wire [w - 1:0] mul_q_3;

    reg_rst_n        i2_arg_vld ( clk , rst_n  , arg_vld_q_2 , arg_vld_q_3 );
    reg_no_rst # (w) i2_n     ( clk ,          n_q_2     , n_q_3     );
    reg_no_rst # (w) i2_mul   ( clk ,          mul_d_2   , mul_q_3   );

    assign res_vld [2]     = arg_vld_q_3;
    assign res     [23:16] = mul_q_3;

    //------------------------------------------------------------------------

    wire [w - 1:0] mul_d_3 = mul_q_3 * n_q_3;

    wire           arg_vld_q_4;
    wire [w - 1:0] n_q_4;
    wire [w - 1:0] mul_q_4;

    reg_rst_n        i3_arg_vld ( clk , rst_n  , arg_vld_q_3 , arg_vld_q_4 );
    reg_no_rst # (w) i3_n     ( clk ,          n_q_3     , n_q_4     );
    reg_no_rst # (w) i3_mul   ( clk ,          mul_d_3   , mul_q_4   );

    assign res_vld [1]    = arg_vld_q_4;
    assign res     [15:8] = mul_q_4;

    //------------------------------------------------------------------------

    wire [w - 1:0] mul_d_4 = mul_q_4 * n_q_4;

    wire           arg_vld_q_5;
    wire [w - 1:0] n_q_5;
    wire [w - 1:0] mul_q_5;

    reg_rst_n        i4_arg_vld ( clk , rst_n  , arg_vld_q_4 , arg_vld_q_5 );
    reg_no_rst # (w) i4_n     ( clk ,          n_q_4     , n_q_5     );
    reg_no_rst # (w) i4_mul   ( clk ,          mul_d_4   , mul_q_5   );

    assign res_vld [0]   = arg_vld_q_5;
    assign res     [7:0] = mul_q_5;

endmodule
