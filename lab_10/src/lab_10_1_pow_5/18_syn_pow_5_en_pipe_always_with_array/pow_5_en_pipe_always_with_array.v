module pow_5_en_pipe_always_with_array
# (
    parameter w = 8
)
(
    input                    clk,
    input                    rst_n,
    input                    clk_en,
    input                    arg_vld,
    input      [w     - 1:0] n,
    output reg [        3:0] res_vld,
    output reg [w * 4 - 1:0] res
);

    reg [w - 1:0] n_reg [1:4];
    reg [w - 1:0] pow   [2:5];
    reg [    1:5] arg_vld_reg;

    integer i;

    always @ (posedge clk or negedge rst_n)

        if (! rst_n)
        begin
            for (i = 1; i <= 5; i = i + 1)
                arg_vld_reg [i] <= 1'b0;
        end
        else if (clk_en)
        begin
            arg_vld_reg [1] <= arg_vld;

            for (i = 1; i <= 4; i = i + 1)
                arg_vld_reg [i + 1] <= arg_vld_reg [i];
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
            res_vld [ 5 - i          ] = arg_vld_reg [i];
            res     [(5 - i) * w +: w] = pow       [i];
        end

endmodule
