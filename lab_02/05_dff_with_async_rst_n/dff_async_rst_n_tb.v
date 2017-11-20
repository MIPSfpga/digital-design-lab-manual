`timescale 1 ns / 100 ps

module dff_async_rst_n_tb;

    reg  d, clk, rst_n;
    wire q;

    dff_async_rst_n i_dff_async_rst_n (d, clk, rst_n, q);
	 
	 initial

    begin

       clk = 0;
       forever
           #5 clk = ! clk;
    end
    
    initial
    begin
        $dumpvars;
        
        $monitor ("%0d d %b clk %b q %b", $time, d, clk, rst_n, q);

        # 10;
        d <= 0;
		  rst_n <= 0;
        # 10;
		  d <= 0;
		  rst_n <= 1;
        # 10;
        d <= 1;
		  rst_n <= 0;
        # 10;
        d <= 1;
		  rst_n <= 1;
        # 10;

        $finish;
    end

endmodule
