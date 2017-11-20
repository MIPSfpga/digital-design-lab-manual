`timescale 1 ns / 100 ps

module dff_simple_tb;

    reg  d, clk;
    wire q;

    dff_simple i_dff (d, clk, q);
	 
	 initial

    begin

       clk = 0;
       forever
           #5 clk = ! clk;
    end
    
    initial
    begin
        $dumpvars;
        
        $monitor ("%0d d %b clk %b q %b", $time, d, clk, q);

        # 10;
        d <= 0;
        # 10;
		  d <= 0;
        # 10;
        d <= 1;
        # 10;
        d <= 0;
        # 10;
        d <= 1;
        # 10;
        d <= 1;
        # 10;
        d <= 0;
        # 10;
        d <= 1;
        # 10;

        $finish;
    end

endmodule
