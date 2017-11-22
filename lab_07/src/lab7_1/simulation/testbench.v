// testbench is a module which only task is to test another module
// testbench is for simulation only, not for synthesis
`timescale 1ns/1ns

module testbench;
    // input and output test signals

	reg [5:0] data_in;
	reg [3:0] addr;
	reg we;
	reg clk;
	wire [5:0] data_out;
	wire [3:0] addr_out;

    // creating the instance of the module we want to test
    //  lab1 - module name
    //  dut  - instance name ('dut' means 'device under test')
    lab7_1 dut (data_in, addr, we, clk, data_out, addr_out);
	
initial 
	begin
		// set inital values of signal
		clk = 0;
		we = 1;
		addr = 4'b0000;
		data_in = 6'b000000; 
		
		// write data in RAM
		#20; 					     			    // pause
			we = 0; 								// write enable
		#20; 					     			    // pause
			addr = 4'b0001; data_in = 6'b000001;	// set test signals value
		#20; 					     			    // pause
			addr = 4'b0010; data_in = 6'b000010;	// set test signals value
		#20; 					     			    // pause
			addr = 4'b0011; data_in = 6'b000011;	// set test signals value
		#20; 					     			    // pause
			addr = 4'b0100; data_in = 6'b000100;	// set test signals value
		#20; 					     			    // pause
			addr = 4'b0101; data_in = 6'b000101;	// set test signals value
		//read data from RAM
		#20; 					     			    // pause	
			we = 1;									// write disable
		#20; 					     			    // pause
			addr = 4'b0000;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b0010;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b0011;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b0100;							// set address signals value
		#20; 					     			    // pause
			addr = 4'b0101;							// set address signals value
	end
	
	//every 10 ns invert clk 
	always #10 clk = ~clk;
	
	initial 
		#300 $finish;
	
   // do at the beginning of the simulation
   // print signal values on every change
   initial 
       $monitor("data_in=%b addr=%b we=%b clk=%b data_out=%b addr_out=%b", 
			data_in, addr, we, clk, data_out, addr_out);

   // do at the beginning of the simulation
   initial 
       $dumpvars;  //iverilog dump init

endmodule
