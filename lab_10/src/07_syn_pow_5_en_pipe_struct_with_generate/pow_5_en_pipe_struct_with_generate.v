module pow_5_en_pipe_struct_with_generate
# (
    parameter w        = 8,
              n_stages = 4
)
(
    input                       clk,
    input                       rst_n,
    input                       clk_en,
    input                       n_vld,
    input  [w            - 1:0] n,
    output [    n_stages - 1:0] res_vld,
    output [w * n_stages - 1:0] res
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
            reg_no_rst_en # (w) i_mul
                (clk, clk_en, mul_d [i], mul_q [i + 1]);
        end

        for (i = 0; i <= n_stages; i = i + 1)
        begin : b_regs
            reg_rst_n_en i_n_vld
                (clk, rst_n, clk_en, n_vld_q [i], n_vld_q [i + 1]);

            reg_no_rst_en # (w) i_n
                (clk, clk_en, n_q [i], n_q [i + 1]);
        end
        
        for (i = 2; i <= n_stages + 1; i = i + 1)
        begin : b_res
            assign res_vld [   n_stages + 1 - i            ] = n_vld_q [i];
            assign res     [ ( n_stages + 1 - i ) * w +: w ] = mul_q   [i];
        end
    
    endgenerate

endmodule
