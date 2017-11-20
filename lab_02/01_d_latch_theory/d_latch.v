
module d_latch
(
    input   clk,
    input   d,
    output  q,
    output  q_n
);
    wire r = ~d & clk;
    wire s = d & clk;

    rs_trigger rs_trigger (s, r, q, q_n);

endmodule