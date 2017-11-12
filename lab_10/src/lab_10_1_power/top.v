
module pow_5_single_cycle
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
    reg_no_rst_en # (8) i_n       (clk, clk_en, n, n_q);

    wire           res_vld_d = n_vld_q;
    wire [w - 1:0] res_d     = n_q  * n_q * n_q * n_q * n_q;

    reg_rst_n_en        i_res_vld (clk, rst_n, clk_en, res_vld_d, res_vld);
    reg_no_rst_en # (8) i_res     (clk, clk_en, res_d, res);

endmodule

//----------------------------------------------------------------------------

module pow_5_single_cycle_alternative_style
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

//----------------------------------------------------------------------------

module pow_5_multiple_cycles
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

module pow_5_multiple_cycles_alternative_style
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

    reg [4:0] shift;

    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
        begin
            shift <= 5'b0;
        end
        else if (clk_en)
        begin
            if (n_vld_q)
                shift <= 5'b10000;
            else
                shift <= shift >> 1;
        end

    assign res_vld = shift [0];

    reg [w - 1:0] mul;

    always @(posedge clk)
        if (clk_en)
        begin
            if (n_vld_q)
                mul <= n_q;
            else
                mul <= mul * n_q;
        end

    assign res = mul;

endmodule

//--------------------------------------------------------------------
/*
module pow_5_pipelined
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

    wire           n_vld_q_1;
    wire [w - 1:0] n_q_1;

    reg_rst_n_en        i0_n_vld   (clk, rst_n, clk_en, n_vld, n_vld_q_1);
    reg_no_rst_en # (8) i0_n       (clk, clk_en, n, n_q_1);

    wire [w - 1:0] mul_d_1 = n_q_1 * n_q_1;

    wire           n_vld_q_1;
    wire [w - 1:0] n_q_2;
    wire [w - 1:0] mul_q_2;

    reg_rst_n_en        i1_n_vld ( clk , rst_n  , clk_en , n_vld_q_1 , n_vld_q_2 );
    reg_no_rst_en # (8) i1_n     ( clk ,          clk_en , n_q_1     , n_q_2     );
    reg_no_rst_en # (8) i1_mul   ( clk ,          clk_en , mul_d_1   , mul_q_2   );

    assign res_vld [0]   = n_vld_q_2;
    assign res     [7:0] = n_q_2;






    wire           res_vld_d = n_vld_q;
    wire [w - 1:0] res_d     = n_q  * n_q * n_q * n_q * n_q;

    reg_rst_n_en        i_res_vld (clk, rst_n, clk_en, res_vld_d, res_vld);
    reg_no_rst_en # (8) i_res     (clk, clk_en, res_d, res);

endmodule
*/
//--------------------------------------------------------------------

module top
(
    input         clk,
    input         rst_n,
    input         clk_en,
    input  [ 3:0] key,
    input  [ 7:0] sw,
    output [ 7:0] led,
    output [ 7:0] disp_en,
    output [31:0] disp,
    output [ 7:0] disp_dot
);

    assign led  = { 7'b0, clk_en };

    wire res_vld;
    
    // pow_5_single_cycle
    // pow_5_single_cycle_alternative_style
    // pow_5_multiple_cycles
    // pow_5_multiple_cycles_alternative_style
    // pow_5_pipelined

    /*

    pow_5_multiple_cycles
    # (.w (8))
    i_pow_5
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

    */

    pow_5_pipelined
    # (.w (8))
    i_pow_5
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
