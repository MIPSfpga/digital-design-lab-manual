module pattern_fsm_moore
(
    input  clock,
    input  reset_n,
    input  enable,
    input  a,
    output y
);

    parameter [1:0] S0 = 0, S1 = 1, S2 = 2;

    reg [1:0] state, next_state;

    // State register

    always @ (posedge clock or negedge reset_n)
        if (! reset_n)
            state <= S0;
        else if (enable)
            state <= next_state;

    // Next state logic

    always @*
        case (state)
        
        S0:
            if (a)
                next_state = S0;
            else
                next_state = S1;

        S1:
            if (a)
                next_state = S2;
            else
                next_state = S1;

        S2:
            if (a)
                next_state = S0;
            else
                next_state = S1;

        default:

            next_state = S0;

        endcase

    // Output logic based on current state

    assign y = (state == S2);

endmodule

module timer
# ( parameter timer_divider = 2 )
(
    input  clock_50_mhz,
    input  reset_n,
    output strobe
);

    reg [timer_divider - 1:0] counter;

    always @ (posedge clock_50_mhz or negedge reset_n)
    begin
        if (! reset_n)
            counter <= { timer_divider { 1'b0 } };
        else
            counter <= counter + { { timer_divider - 1 { 1'b0 } }, 1'b1 };
    end

    assign strobe
        = (counter [timer_divider - 1:0] == { timer_divider { 1'b0 } } );

endmodule

module shift
# ( parameter width = 10 )
(
    input                     clock,
    input                     reset_n,
    input                     shift_enable,
    input                     button,
    output reg [width - 1:0]  shift_reg,
    output                    out
);

    always @ (posedge clock or negedge reset_n)
    begin
        if (! reset_n)
            shift_reg <= { width { 1'b0 } };
        else if (shift_enable)
            shift_reg <= { button, shift_reg [width - 1:1] };
    end

    assign out = shift_reg [0];

endmodule

//----------------------------------------------------------------------------
//
//  Exercise with Mealy FSM
//
//----------------------------------------------------------------------------

module pattern_fsm_mealy
(
    input  clock,
    input  reset_n,
    input  enable,
    input  a,
    output y
);

    parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b11, S3 = 2'b10;

    reg [1:0] state, next_state;

    // State register

    always @ (posedge clock or negedge reset_n)
        if (! reset_n)
            state <= S0;
        else if (enable)
            state <= next_state;

    // Next state logic

    always @*
        case (state)
        
        S0:
            if (a)
                next_state = S0;
            else
                next_state = S1;

        S1:
            if (a)
                next_state = S1;
            else
                next_state = S2;

		 S2:
            if (a)
                next_state = S0;
            else
                next_state = S3;

		 S3:
            if (a)
                next_state = S2;
            else
                next_state = S0;

        default:

            next_state = S0;

        endcase

    // Output logic based on current state

    assign y = (a & state == S1);

endmodule

//----------------------------------------------------------------------------

module lab8
(
    input        clock,    // Clock signal 50 MHz
    input        reset_n,  // Reset active low
    input        key,      // Button
    output [9:0] led,      // LEDs
    output [6:0] hex0,     // 7-segment display
    output [6:0] hex1
);

    wire       button  = ~ key;
    wire       enable;
    wire [9:0] shift_data;
    wire       shift_out;
	wire       moore_fsm_out;
	wire       mealy_fsm_out;


    timer
    # ( .timer_divider ( 2 ))
    timer_i
    (
        .clock_50_mhz ( clock   ),
        .reset_n      ( reset_n ),
        .strobe       ( enable  )
    );

    shift 
    # ( .width ( 10 ))
    shift_i
    (
        .clock        ( clock      ),
        .reset_n      ( reset_n    ),
        .shift_enable ( enable     ),
        .button       ( button     ),
        .shift_reg    ( shift_data ),
        .out          ( shift_out  )
    );

    assign led = shift_data;

    pattern_fsm_moore fsm_moore
    (
        .clock   ( clock         ),
        .reset_n ( reset_n       ),
        .enable  ( enable        ),
        .a       ( shift_out     ),
        .y       ( moore_fsm_out )
    );

    pattern_fsm_mealy fsm_mealy
    (
        .clock   ( clock         ),
        .reset_n ( reset_n       ),
        .enable  ( enable        ),
        .a       ( shift_out     ),
        .y       ( mealy_fsm_out )
    );

    assign hex0 = moore_fsm_out ? 8'b10100011 : 8'b11111111;
    assign hex1 = mealy_fsm_out ? 8'b10011100 : 8'b11111111;

endmodule
