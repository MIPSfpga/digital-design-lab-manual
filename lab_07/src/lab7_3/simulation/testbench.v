// testbench is a module which only task is to test another module
// testbench is for simulation only, not for synthesis
`timescale 1ns/1ns
module testbench;
    // input and output test signals

	reg [2:0] data_in;
	reg [2:0] read_addr;
	reg [2:0] write_addr;
	reg we;
	reg clk;
	wire [2:0] data_out;

    // creating the instance of the module we want to test
    //  lab7_3 - module name
    //  dut  - instance name ('dut' means 'device under test')
    lab7_3 dut (data_in, read_addr, write_addr, we, clk, data_out);
	
initial 
	begin
		// set inital values of signal
		clk = 1;
		we = 1;
		read_addr = 3'b000;
		write_addr = 3'b000;
		data_in = 3'b000; 
		
		// write data in RAM
		#20; 					     			    // pause
			write_addr = 3'b001;
	   	data_in = 3'b001; 

		#20; 					     			    // pause
			read_addr = 3'b001;
	   	data_in = 3'b010; 
		#20; 					     			    // pause
		   write_addr = 3'b010;
		   data_in = 3'b011; 
		#20; 					     			    // pause
		   read_addr = 3'b010;
		   data_in = 3'b100; 
         we = 0;
		#20; 					     			    // pause
         write_addr = 3'b011;
		   data_in = 3'b101; 
			we = 1;
		#20; 					     			    // pause
		   read_addr = 3'b011;
		   data_in = 3'b110; 
		#20; 					     			    // pause
		   write_addr = 3'b100;
		   data_in = 3'b011; 
		#20; 					     			    // pause
		   read_addr = 3'b100;
		   data_in = 3'b100; 
		#20; 					     			    // pause
         write_addr = 3'b101;
		   data_in = 3'b101; 
	end
	
	//every 10 ns invert clk 
	always #10 clk = ~clk;


	initial 
		#200 $finish;
	
   // do at the beginning of the simulation
   // print signal values on every change
   initial 
       $monitor("data_in=%b read_addr=%b write_addr=%b we=%b clk=%b data_out=%b", 
			data_in, read_addr, write_addr, we, clk, data_out);

   // do at the beginning of the simulation
   initial 
       $dumpvars;  //iverilog dump init

endmodule
