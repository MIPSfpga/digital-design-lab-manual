`timescale 1 ns / 100 ps

module d_latch_tb;

    reg  d, r_n, en;
    wire q;

    d_latch i_d_latch (d, r_n, en, q);
    
    initial
    begin
        $dumpvars;
        
        $monitor ("%0d d %b r_n %b en %b q %b", $time, d, r_n, en, q);

        # 10;
        d <= 0;
        r_n <= 0;
		  en <= 0;
        # 10;
        d <= 0;
        r_n <= 0;
		  en <= 1;
        # 10;
        d <= 0;
        r_n <= 1;
		  en <= 0;
        # 10;
        d <= 0;
        r_n <= 1;
		  en <= 1;
        # 10;
        d <= 1;
        r_n <= 0;
		  en <= 0;
        # 10;
        d <= 1;
        r_n <= 0;
		  en <= 1;
        # 10;
        d <= 1;
        r_n <= 1;
		  en <= 0;
        # 10;
        d <= 1;
        r_n <= 1;
		  en <= 1;
        # 10;

        $finish;
    end

endmodule
