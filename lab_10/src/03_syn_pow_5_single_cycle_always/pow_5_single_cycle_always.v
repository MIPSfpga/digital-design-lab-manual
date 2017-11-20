module pow_5_single_cycle_always
# (
    parameter w = 8
)
(
    input                clk,
    input                rst_n,
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
        else
            n_vld_q <= n_vld;
    
    always @ (posedge clk)
        n_q <= n;

    wire           res_vld_d = n_vld_q;
    wire [w - 1:0] res_d     = n_q  * n_q * n_q * n_q * n_q;

    always @ (posedge clk or negedge rst_n)
        if (! rst_n)
            res_vld <= 1'b0;
        else
            res_vld <= res_vld_d;

    always @ (posedge clk)
        res <= res_d;

endmodule
