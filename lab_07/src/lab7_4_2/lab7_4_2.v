module lab7_4_2

#(parameter DATA_WIDTH=8, parameter STACK_SIZE=4)

(
    input  clock,
    input  reset,
    input  push,
    input  pop,

    input  [DATA_WIDTH - 1:0] write_data,
    output reg [DATA_WIDTH - 1:0] read_data
);

    reg [DATA_WIDTH - 1:0] stack [0:STACK_SIZE - 1];
	reg [STACK_SIZE - 1:0] pointer;

 
	always @(posedge clock) 
	  begin
		if (reset)
			pointer <= 0;
			
		else if (push)
			pointer <= pointer + 1;
			
		else if (pop)
			pointer <= pointer - 1;
    end

	 
	always @(posedge clock) 
	begin
		if (push || pop) 
		begin
			if(push)
				stack[pointer] <= write_data;

         read_data = stack [pointer - 1];
		end
	end
	
endmodule