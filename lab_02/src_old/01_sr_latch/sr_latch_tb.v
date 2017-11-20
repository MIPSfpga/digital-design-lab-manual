`timescale 1 ns / 100 ps

module sr_latch_tb;

    reg  s, r;
    wire q, q_n;

    sr_latch i_sr_latch (s, r, q, q_n);
    
    initial
    begin
        $dumpvars;
        
        $monitor ("%0d s %b r %b q %b q_n %b", $time, s, r, q, q_n);

        # 10;
        s <= 0;
        r <= 0;
        # 10;
        s <= 1;
        r <= 0;
        # 10;
        s <= 0;
        r <= 0;
        # 10;
        s <= 0;
        r <= 1;
        # 10;
        s <= 0;
        r <= 0;
        # 10;
        s <= 1;
        r <= 1;
        # 10;
        s <= 0;
        r <= 0;
        # 10;
        s <= 0;
        r <= 0;
        # 10;

        $finish;
    end

endmodule
