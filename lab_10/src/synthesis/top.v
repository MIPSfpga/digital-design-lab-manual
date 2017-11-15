
module pow_5_en_single_cycle_struct
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
    wire [w - 1:0] res_d     = n_q * n_q * n_q * n_q * n_q;

    reg_rst_n_en        i_res_vld (clk, rst_n, clk_en, res_vld_d, res_vld);
    reg_no_rst_en # (8) i_res     (clk, clk_en, res_d, res);

endmodule

//----------------------------------------------------------------------------

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

//----------------------------------------------------------------------------

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

module pow_5_en_multi_cycle_always
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
    reg_no_rst_en # (8) i0_n       (clk, clk_en, n, n_q_1);

    //------------------------------------------------------------------------

    wire [w - 1:0] mul_d_1 = n_q_1 * n_q_1;

    wire           n_vld_q_2;
    wire [w - 1:0] n_q_2;
    wire [w - 1:0] mul_q_2;

    reg_rst_n_en        i1_n_vld ( clk , rst_n  , clk_en , n_vld_q_1 , n_vld_q_2 );
    reg_no_rst_en # (8) i1_n     ( clk ,          clk_en , n_q_1     , n_q_2     );
    reg_no_rst_en # (8) i1_mul   ( clk ,          clk_en , mul_d_1   , mul_q_2   );

    assign res_vld [3]   = n_vld_q_2;
    assign res     [31:24] = mul_q_2;
    
    //------------------------------------------------------------------------

    wire [w - 1:0] mul_d_2 = mul_q_2 * n_q_2;

    wire           n_vld_q_3;
    wire [w - 1:0] n_q_3;
    wire [w - 1:0] mul_q_3;

    reg_rst_n_en        i2_n_vld ( clk , rst_n  , clk_en , n_vld_q_2 , n_vld_q_3 );
    reg_no_rst_en # (8) i2_n     ( clk ,          clk_en , n_q_2     , n_q_3     );
    reg_no_rst_en # (8) i2_mul   ( clk ,          clk_en , mul_d_2   , mul_q_3   );

    assign res_vld [2]     = n_vld_q_3;
    assign res     [23:16] = mul_q_3;

    //------------------------------------------------------------------------

    wire [w - 1:0] mul_d_3 = mul_q_3 * n_q_3;

    wire           n_vld_q_4;
    wire [w - 1:0] n_q_4;
    wire [w - 1:0] mul_q_4;

    reg_rst_n_en        i3_n_vld ( clk , rst_n  , clk_en , n_vld_q_3 , n_vld_q_4 );
    reg_no_rst_en # (8) i3_n     ( clk ,          clk_en , n_q_3     , n_q_4     );
    reg_no_rst_en # (8) i3_mul   ( clk ,          clk_en , mul_d_3   , mul_q_4   );

    assign res_vld [1]    = n_vld_q_4;
    assign res     [15:8] = mul_q_4;

    //------------------------------------------------------------------------

    wire [w - 1:0] mul_d_4 = mul_q_4 * n_q_4;

    wire           n_vld_q_5;
    wire [w - 1:0] n_q_5;
    wire [w - 1:0] mul_q_5;

    reg_rst_n_en        i4_n_vld ( clk , rst_n  , clk_en , n_vld_q_4 , n_vld_q_5 );
    reg_no_rst_en # (8) i4_n     ( clk ,          clk_en , n_q_4     , n_q_5     );
    reg_no_rst_en # (8) i4_mul   ( clk ,          clk_en , mul_d_4   , mul_q_5   );

    assign res_vld [0]   = n_vld_q_5;
    assign res     [7:0] = mul_q_5;

endmodule

//--------------------------------------------------------------------

module pow_5_en_pipe_struct_with_generate
# (
    parameter w        = 8,
              n_stages = 4
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

    wire [w - 1:0] mul_d     [ 1 : n_stages     ];

    wire           n_vld_q   [ 0 : n_stages + 1 ];
    wire [w - 1:0] n_q       [ 0 : n_stages + 1 ];
    wire [w - 1:0] mul_q     [ 2 : n_stages + 1 ];

    assign n_vld_q [0] = n_vld;
    assign n_q     [0] = n;
    
    assign mul_d   [1] = n_q [1] * n_q [1];

    generate
    
        genvar i;
    
        for (i = 2; i <= n_stages; i = i + 1)
        begin : b_mul
            assign mul_d [i] = mul_q [i] * n_q [i];
        end

        for (i = 1; i <= n_stages; i = i + 1)
        begin : b_mul_reg
            reg_no_rst_en # (8) i_mul
                (clk, clk_en, mul_d [i], mul_q [i + 1]);
        end

        for (i = 0; i <= n_stages; i = i + 1)
        begin : b_regs
            reg_rst_n_en i_n_vld
                (clk, rst_n, clk_en, n_vld_q [i], n_vld_q [i + 1]);

            reg_no_rst_en # (8) i_n
                (clk, clk_en, n_q [i], n_q [i + 1]);
        end
        
        for (i = 2; i <= n_stages + 1; i = i + 1)
        begin : b_res
            assign res_vld [   n_stages + 1 - i            ] = n_vld_q [i];
            assign res     [ ( n_stages + 1 - i ) * w +: w ] = mul_q   [i];
        end
    
    endgenerate

endmodule

//--------------------------------------------------------------------

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

module pow_5_en_pipe_always_with_array
# (
    parameter w = 8
)
(
    input                    clk,
    input                    rst_n,
    input                    clk_en,
    input                    n_vld,
    input      [w     - 1:0] n,
    output reg [        3:0] res_vld,
    output reg [w * 4 - 1:0] res
);

    reg [w - 1:0] n_reg [1:4];
    reg [w - 1:0] pow   [2:5];
    reg [    1:5] n_vld_reg;

    integer i;

    always @ (posedge clk or negedge rst_n)

        if (! rst_n)
        begin
            for (i = 1; i <= 5; i = i + 1)
                n_vld_reg [i] <= 1'b0;
        end
        else if (clk_en)
        begin
            n_vld_reg [1] <= n_vld;

            for (i = 1; i <= 4; i = i + 1)
                n_vld_reg [i + 1] <= n_vld_reg [i];
        end

    always @ (posedge clk)

        if (clk_en)
        begin
            n_reg [1] <= n;

            for (i = 1; i <= 3; i = i + 1)
                n_reg [i + 1] <= n_reg [i];

            pow [2] <= n_reg [1] * n_reg [1];

            for (i = 2; i <= 4; i = i + 1)
                pow [i + 1] <= pow [i] * n_reg [i];
        end

    always @*

        for (i = 2; i <= 5; i = i + 1)
        begin
            res_vld [ 5 - i          ] = n_vld_reg [i];
            res     [(5 - i) * w +: w] = pow       [i];
        end

endmodule

//--------------------------------------------------------------------

module pow_5_en_pipe_always_with_array_and_n_stages
# (
    parameter w        = 8,
              n_stages = 4 
)
(
    input                             clk,
    input                             rst_n,
    input                             clk_en,
    input                             n_vld,
    input      [ w            - 1:0 ] n,
    output reg [     n_stages - 1:0 ] res_vld,
    output reg [ w * n_stages - 1:0 ] res
);

    reg [ w - 1 :            0 ] n_reg [ 1 : n_stages     ];
    reg [ w - 1 :            0 ] pow   [ 2 : n_stages + 1 ];
    reg [     1 : n_stages + 1 ] n_vld_reg;

    integer i;

    always @ (posedge clk or negedge rst_n)

        if (! rst_n)
        begin
            for (i = 1; i <= n_stages + 1; i = i + 1)
                n_vld_reg [i] <= 1'b0;
        end
        else if (clk_en)
        begin
            n_vld_reg [1] <= n_vld;

            for (i = 1; i <= n_stages; i = i + 1)
                n_vld_reg [i + 1] <= n_vld_reg [i];
        end

    always @ (posedge clk)

        if (clk_en)
        begin
            n_reg [1] <= n;

            for (i = 1; i <= n_stages - 1; i = i + 1)
                n_reg [i + 1] <= n_reg [i];

            pow [2] <= n_reg [1] * n_reg [1];

            for (i = 2; i <= n_stages; i = i + 1)
                pow [i + 1] <= pow [i] * n_reg [i];
        end

    always @*

        for (i = 2; i <= n_stages + 1; i = i + 1)
        begin
            res_vld [  n_stages + 1 - i           ] = n_vld_reg [i];
            res     [ (n_stages + 1 - i) * w +: w ] = pow       [i];
        end

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

/*
    wire res_vld;
    
    assign led  = { 8 { res_vld } };

    // pow_5_en_single_cycle_struct
    // pow_5_en_single_cycle_always
    // pow_5_en_multi_cycle_struct
    // pow_5_en_multi_cycle_always
    // pow_5_en_pipe_struct

    /*

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

    */

    wire [3:0] res_vld;

    // pow_5_en_pipe_struct
    // pow_5_en_pipe_always
    // pow_5_en_pipe_always_with_array # (.w (8))
    // pow_5_en_pipe_always_with_array_and_n_stages
    // pow_5_en_pipe_always_with_generate

    pow_5_en_pipe_struct_with_generate
    # (.w (8), .n_stages (4))
    i_pow_5_en
    (
/*
        .clk     ( fast_clk    ),
        .rst_n   ( rst_n       ),
        .clk_en  ( fast_clk_en ),
*/
        .clk     ( slow_clk    ),
        .rst_n   ( rst_n       ),
        .clk_en  ( 1'b1        ),
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
