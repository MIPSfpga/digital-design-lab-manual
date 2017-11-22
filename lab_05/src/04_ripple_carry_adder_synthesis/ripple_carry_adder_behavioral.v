module ripple_carry_adder_behavioral
# (
    parameter width = 8
)
(
    input    [ width - 1 : 0 ] x,
    input    [ width - 1 : 0 ] y,
    output   [ width - 1 : 0 ] z,
	output                     carry_out
);

    wire [ width - 1 : 0 ] carry;

    generate
    
        genvar i;
    
        for (i = 0; i <= width - 1; i = i + 1)
        begin : stage
		case (i)
		0 : begin
			assign z[i]     = x[i] ^ y[i];
            assign carry[i] = x[i] & y[i];
		end
		width - 1 : begin
			assign z[i]      = x[i] ^ y[i] ^ carry[i - 1];
            assign carry_out = x[i] & y[i] | carry[i - 1] & (x[i] | y[i]) ;
		end
		default : begin
			assign z[i]     = x[i] ^ y[i] ^ carry[i - 1];
            assign carry[i] = x[i] & y[i] | carry[i - 1] & (x[i] | y[i]) ;
			);
		end
		endcase
		end
		
    endgenerate

endmodule