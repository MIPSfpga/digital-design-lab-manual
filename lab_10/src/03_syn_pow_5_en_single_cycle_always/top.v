module pow_5_en_single_cycle_always
# (
    parameter w = 8
)
(
    input                clk,
    input                rst_n,
    input                clk_en,
    input                n_vld,
    input      [w - 1:0] n,
    output reg           res_vld,
    output reg [w - 1:0] res
);

    reg           n_vld_q;
    reg [w - 1:0] n_q;

    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            n_vld_q <= 1'b0;
        else if (clk_en)
            n_vld_q <= n_vld;
    
    always @ (posedge clk)
        if (clk_en)
            n_q <= n;

    wire           res_vld_d = n_vld_q;
    wire [w - 1:0] res_d     = n_q  * n_q * n_q * n_q * n_q;

    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            res_vld <= 1'b0;
        else if (clk_en)
            res_vld <= res_vld_d;

    always @ (posedge clk)
        if (clk_en)
            res <= res_d;

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

    wire res_vld;
    
    assign led  = { 8 { res_vld } };

    pow_5_en_single_cycle_always
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
