
module d_flip_flop
(
    input   clk,
    input   d,
    output  q,
    output  q_n
);
    wire n1;

    d_latch l1
    (
        .clk ( ~clk ),
        .d   ( d    ),
        .q   ( n1   )
    );

    d_latch l2
    (
        .clk ( clk ),
        .d   ( n1  ),
        .q   ( q   ),
        .q_n ( q_n )
    );

endmodule
