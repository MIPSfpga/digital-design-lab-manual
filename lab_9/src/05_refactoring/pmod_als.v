/*
 * Digital Design Lab Manual
 * Lab #9
 *
 * Copyright(c) 2017 Stanislav Zhelnio 
 *
 */
 
module pmod_als
#(
    parameter QUERY_DELAY = 40
)
(
    input             clk,
    input             rst_n,
    output reg        cs,
    output reg        sck,
    input             sdo,
    output      [7:0] value
);

    localparam  S_IDLE       = 0,
                S_PREFIX     = 1,
                S_DATA       = 2,
                S_POSTFIX    = 3;

    localparam  IDLE_SIZE    = QUERY_DELAY,
                PREFIX_SIZE  = 2,
                DATA_SIZE    = 7,
                POSTFIX_SIZE = 6;

    // sck clock devider
    wire sck_edge;
    wire sck_out;
    sck_clk_devider scd
    (
        .clk        ( clk      ),
        .rst_n      ( rst_n    ),
        .sck        ( sck_out  ),
        .sck_edge   ( sck_edge )
    );

    // State hold registers
    wire [1:0] State;
    reg  [1:0] Next;
    register #(.SIZE(2)) r_state(clk, rst_n, Next, State);

    wire [23:0] cnt;
    reg  [23:0] cntNext;
    register #(.SIZE(24)) r_cnt(clk, rst_n, cntNext, cnt);

    wire [7:0] buffer;
    reg  [7:0] bufferNext;
    register #(.SIZE(8)) r_buffer(clk, rst_n, bufferNext, buffer);

    reg  [7:0] valueNext;
    register #(.SIZE(8)) r_value(clk, rst_n, valueNext, value);

    // Next state determining
    always @(*) begin
        Next = State;
        if(sck_edge)
            case(State)
                S_IDLE    : if(cnt == IDLE_SIZE)    Next = S_PREFIX;
                S_PREFIX  : if(cnt == PREFIX_SIZE)  Next = S_DATA;
                S_DATA    : if(cnt == DATA_SIZE)    Next = S_POSTFIX;
                S_POSTFIX : if(cnt == POSTFIX_SIZE) Next = S_IDLE;
            endcase
    end

    always @(*) begin
        cntNext = cnt;
        if(sck_edge)
            case(State)
                S_IDLE    : cntNext = (cnt == IDLE_SIZE)    ? 0 : cnt + 1;
                S_PREFIX  : cntNext = (cnt == PREFIX_SIZE)  ? 0 : cnt + 1;
                S_DATA    : cntNext = (cnt == DATA_SIZE)    ? 0 : cnt + 1;
                S_POSTFIX : cntNext = (cnt == POSTFIX_SIZE) ? 0 : cnt + 1;
            endcase
    end

    always @(*) begin
        bufferNext = buffer;
        valueNext = value;
        if(sck_edge)
            case(State)
                S_DATA    : bufferNext = { bufferNext[6:0], sdo };
                S_POSTFIX : valueNext = bufferNext;
            endcase
    end

    // output
    always @(*) begin
        case(State)
            S_IDLE    : begin cs = 1'b1; sck = 1'b0;    end
            S_PREFIX  : begin cs = 1'b0; sck = sck_out; end
            S_DATA    : begin cs = 1'b0; sck = sck_out; end
            S_POSTFIX : begin cs = 1'b0; sck = sck_out; end
        endcase
    end

endmodule


module sck_clk_devider
(
    input       clk,
    input       rst_n,
    output      sck,
    output      sck_edge
);
    wire [3:0] cnt;
    wire [3:0] cntNext = cnt + 1;
    register #(.SIZE(4)) r_cnt(clk, rst_n, cntNext, cnt);

    assign sck = cnt[3];
    assign sck_edge = (cnt == 4'b1000);

endmodule

