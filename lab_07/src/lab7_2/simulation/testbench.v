// testbench is a module which only task is to test another module
// testbench is for simulation only, not for synthesis
`timescale 1ns/1ns
module testbench;
    // input and output test signals

	reg clk;
	reg [3:0] addr;
	wire [5:0] data_out;
	wire [3:0] addr_out;
	integer i;
 
    // creating the instance of the module we want to test
    //  lab1 - module name
    //  dut  - instance name ('dut' means 'device under test')
    lab7_2 dut (clk, addr, data_out, addr_out);
	
initial 
	begin
		// set inital values of signal
		clk = 0;
		#20; 					     			    // pause
			addr = 4'b0000;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b0001;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b0010;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b0011;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b0100;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b0101;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b0110;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b0111;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b1000;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b1001;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b1010;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b1011;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b1100;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b1101;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b1110;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b1111;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b0000;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b0001;							// set address signals value
	end
	
	//every 10 ns invert clk 
	always #10 clk = ~clk;
	
	initial 
		#500 $finish;
	
   
   // do at the beginning of the simulation
   // print signal values on every change
   initial 
       $monitor("clk=%b addr=%b data_out=%b addr_out=%b", 
			clk, addr, data_out, addr_out);

   // do at the beginning of the simulation
   initial 
       $dumpvars;  //iverilog dump init

endmodule
