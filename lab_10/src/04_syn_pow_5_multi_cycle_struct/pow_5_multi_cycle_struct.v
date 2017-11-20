module pow_5_multi_cycle_struct
# (
    parameter w = 8
)
(
    input            clk,
    input            rst_n,
    input            n_vld,
    input  [w - 1:0] n,
    output           res_vld,
    output [w - 1:0] res
);

    wire             n_vld_q;
    wire   [w - 1:0] n_q;

    reg_rst_n        i_n_vld (clk, rst_n, n_vld, n_vld_q);
    reg_no_rst # (w) i_n     (clk, n, n_q);

    wire [4:0] shift_q;
    wire [4:0] shift_d = n_vld_q ? 5'b10000 : shift_q >> 1;
   
    reg_rst_n # (5) i_shift (clk, rst_n, shift_d, shift_q);
    
    assign res_vld = shift_q [0];

    wire [w - 1:0] mul_q;
    wire [w - 1:0] mul_d = n_vld_q ? n_q : mul_q * n_q;

    wire mul_en = 1;  // n_vld_q || shift_q [4:1] != 4'b0;

    reg_no_rst_en # (w) i_mul (clk, mul_en, mul_d, mul_q);
    
    assign res = mul_q;

endmodule
