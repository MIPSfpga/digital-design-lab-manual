module ripple_carry_adder
# (
    parameter width = 8
)
(
    input    [ width - 1 : 0 ] x,
    input    [ width - 1 : 0 ] y,
    output   [ width     : 0 ] z,
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
				.x( x [i] ),
				.y( y [i] ),
				.z( z [i] )
			)
		end
		width - 1 : begin
			full_adder FA
			(
				.x		   ( x [i] ),
				.y         ( y [i] ),
				.carry_in  ( carry [i - 1] ),
				.z         ( z [i] )
				.carry_out ( carry_out )
			)
		end
		default : begin
			full_adder FA
			(
				.x		   ( x [i] ),
				.y         ( y [i] ),
				.carry_in  ( carry [i - 1] ),
				.z         ( z [i] )
				.carry_out ( carry [i] )
			)
		end
		
    endgenerate

endmodule

//--------------------------------------------------------------------

`ifndef SIMULATION

module top
(
    input         fast_clk,
    input         slow_clk,
    input         rst_n,
    input         fast_clk_en,
    input  [ 3:0] key,
    input  [ 7:0] sw,
    output [ 7:0] led,
    output [ 7:0] disp_en,
    output [31:0] disp,
    output [ 7:0] disp_dot
);

    wire [3:0] res_vld;

    pow_5_en_pipe_struct_with_generate
    # (.w (8), .n_stages (4))
    i_pow_5_en
    (
        .clk     ( fast_clk    ),
        .rst_n   ( rst_n       ),
        .clk_en  ( fast_clk_en ),
        .n_vld   ( key [0]     ),
        .n       ( sw          ),
        .res_vld ( res_vld     ),
        .res     ( disp [31:0] )
    );

    assign disp_en  =
    {
        res_vld [3], res_vld [3],
        res_vld [2], res_vld [2],
        res_vld [1], res_vld [1],
        res_vld [0], res_vld [0]
    };

    assign disp_dot = 8'b0;

endmodule

`endif