module pow_5_en_multi_cycle_struct
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

    reg_rst_n_en        i_n_vld (clk, rst_n, clk_en, n_vld, n_vld_q);
    reg_no_rst_en # (8) i_n     (clk, clk_en, n, n_q);

    wire [4:0] shift_d = n_vld_q ? 5'b10000 : shift_q >> 1;
    wire [4:0] shift_q;
   
    reg_rst_n_en # (5) i_shift (clk, rst_n, clk_en, shift_d, shift_q);
    
    assign res_vld = shift_q [0];

    wire [w - 1:0] mul_d = n_vld_q ? n_q : mul_q * n_q;
    wire [w - 1:0] mul_q;

    wire mul_en = clk_en;  // && (n_vld_q || shift_q [4:1] != 4'b0);

    reg_no_rst_en # (8) i_mul (clk, mul_en, mul_d, mul_q);
    
    assign res = mul_q;

endmodule

//----------------------------------------------------------------------------

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

    wire res_vld;
    
    assign led  = { 8 { res_vld } };

    pow_5_en_multi_cycle_struct
    # (.w (8))
    i_pow_5_en
    (
        .clk     ( clk        ),
        .rst_n   ( rst_n      ),
        .clk_en  ( clk_en     ),
        .n_vld   ( key [0]    ),
        .n       ( sw         ),
        .res_vld ( res_vld    ),
        .res     ( disp [7:0] )
    );
    
    assign disp_en  = 8'b00000011;
    assign disp_dot = { 7'b0000000, res_vld };

endmodule

`endif
