module pow_5_single_cycle_struct
# (
    parameter w = 8
)
(
    input            clk,
    input            rst_n,
    input            clk_en,
    input            n_vld,
    input  [w - 1:0] n,
    output           res_vld,
    output [w - 1:0] res
);

    wire           n_vld_q;
    wire [w - 1:0] n_q;

    reg_rst_n_en        i_n_vld   (clk, rst_n, clk_en, n_vld, n_vld_q);
    reg_no_rst_en # (w) i_n       (clk, clk_en, n, n_q);

    wire           res_vld_d = n_vld_q;
    wire [w - 1:0] res_d     = n_q * n_q * n_q * n_q * n_q;

    reg_rst_n_en        i_res_vld (clk, rst_n, clk_en, res_vld_d, res_vld);
    reg_no_rst_en # (w) i_res     (clk, clk_en, res_d, res);

endmodule
