`timescale 1 ns / 100 ps

module dff_sync_rst_n_parameterized_tb;

    reg [3:0] d;
	 reg  clk, rst_n;
    wire [3:0] q;

    dff_sync_rst_n_parameterized #(4) i_dff_sync_rst_n_parameterized (d, clk, rst_n, q);
	 
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
        d <= 4'b0001;
		  rst_n <= 0;
        # 10;
		  d <= 4'b0011;
		  rst_n <= 1;
        # 10;
        d <= 4'b0111;
		  rst_n <= 0;
        # 10;
        d <= 4'b1111;
		  rst_n <= 1;
        # 10;

        $finish;
    end

endmodule
