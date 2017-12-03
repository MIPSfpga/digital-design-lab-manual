// testbench is a module which only task is to test another module
// testbench is for simulation only, not for synthesis
`timescale 1ns/1ns
module testbench;
    // input and output test signals

    reg clock;
    reg reset_n;
    reg key;
    wire [9:0] led;
    wire [6:0] hex0;
    wire [6:0] hex1;    

    // creating the instance of the module we want to test
    //  lab8 - module name
    //  dut  - instance name ('dut' means 'device under test')
    lab8 dut (clock, reset_n, key, led,    hex0, hex1);
    
initial 
    begin
        // set inital values of signal
        clock = 1;
        reset_n = 0;
        key = 1;
        
        #40;                                          // pause
           reset_n = 1;
        #20;                                          // pause
           key = 0;
        #200;                                         // pause
           key = 1;
        #100;                                          // pause
           key = 0;
    end
    
    //every 10 ns invert clk 
    always #10 clock = ~clock;


    initial 
        #2000 $finish;
    
   // do at the beginning of the simulation
   // print signal values on every change
   initial 
       $monitor("clock=%b, reset_n=%b, key=%b, led=%b, hex0=%b, hex1=%b", 
            clock, reset_n, key, led, hex0, hex1);

   // do at the beginning of the simulation
   initial 
       $dumpvars;  //iverilog dump init

endmodule