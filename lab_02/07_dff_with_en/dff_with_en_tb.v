`timescale 1 ns / 100 ps

module dff_with_en_tb;

    reg  d, clk, en;
    wire q;

    dff_with_en i_dff_with_en (d, clk, en, q);
	 
	 initial

    begin

       clk = 0;
       forever
           #5 clk = ! clk;
    end
    
    initial
    begin
        $dumpvars;
        
        $monitor ("%0d d %b clk %b q %b", $time, d, clk, en, q);

        # 10;
        d <= 0;
		  en <= 0;
        # 10;
		  d <= 0;
		  en <= 1;
        # 10;
        d <= 1;
		  en <= 0;
        # 10;
        d <= 1;
		  en <= 1;
        # 10;

        $finish;
    end

endmodule
