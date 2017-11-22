module ripple_carry_adder
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
			half_adder HA
			(
				.x        ( x [i] ),
				.y        ( y [i] ),
				.z        ( z [i] ),
				.carry_out( carry [i] )
			);
		end
		width - 1 : begin
			full_adder FA
			(
				.x		   ( x [i] ),
				.y         ( y [i] ),
				.carry_in  ( carry [i - 1] ),
				.z         ( z [i] ),
				.carry_out ( carry_out )
			);
		end
		default : begin
			full_adder FA
			(
				.x		   ( x [i] ),
				.y         ( y [i] ),
				.carry_in  ( carry [i - 1] ),
				.z         ( z [i] ),
				.carry_out ( carry [i] )
			);
		end
		endcase
		end
		
    endgenerate

endmodule