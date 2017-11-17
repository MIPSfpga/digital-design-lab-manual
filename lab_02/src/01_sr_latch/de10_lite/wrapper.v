module wrapper
(
    input  [ 1:0] KEY,
    output [ 9:0] LEDR
);

    sr_latch i_sr_latch
    (
        .s   ( ~ KEY  [0] ),
        .r   ( ~ KEY  [1] ),
        .q   (   LEDR [1] ),
        .q_n (   LEDR [0] )
    );

endmodule
