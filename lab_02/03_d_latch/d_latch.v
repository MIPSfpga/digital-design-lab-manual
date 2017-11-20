module d_latch
(
    input  d,
    input  rst_n,
    input en,
    output reg q
);

    always @ (en or rst_n or d)
      if (!rst_n)
         q <= 0;
      else
         if (en)
            q <= d;

endmodule
