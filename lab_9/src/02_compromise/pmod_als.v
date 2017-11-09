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
    output reg  [7:0] value
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
    reg  [ 1:0] State;
    reg  [ 1:0] Next;
    reg  [23:0] cnt;
    reg  [23:0] cntNext;
    reg  [ 7:0] buffer;
    reg  [ 7:0] bufferNext;
    reg  [ 7:0] valueNext;

    always @ (posedge clk or negedge rst_n)
        if(~rst_n) begin
            State  <= S_IDLE;
            cnt    <= 24'b0;
            buffer <= 8'b0;
            value  <= 8'b0;
            end
        else begin
            State  <= Next;
            cnt    <= cntNext;
            buffer <= bufferNext;
            value  <= valueNext;
        end

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
    output  reg sck,
    output  reg sck_edge
);
    localparam  S_DOWN = 0,
                S_EDGE = 1,
                S_UP   = 2;

    localparam  DOWN_SIZE = 7,
                EP_SIZE = DOWN_SIZE - 1; // because 1 cycle of S_EDGE;

    // State hold registers
    reg  [1:0] State;
    reg  [1:0] Next;
    reg  [2:0] cnt;
    reg  [2:0] cntNext;

    always @ (posedge clk or negedge rst_n)
        if(~rst_n) begin
            State  <= S_DOWN;
            cnt    <= 3'b0;
            end
        else begin
            State  <= Next;
            cnt    <= cntNext;
        end

    // Next state determining
    always @(*) begin
        Next = State;
        case(State)
            S_DOWN  : if(cnt == DOWN_SIZE) Next = S_EDGE;
            S_EDGE  : Next = S_UP;
            S_UP    : if(cnt == EP_SIZE) Next = S_DOWN;
        endcase
    end

    always @(*) begin
        case(State)
            S_DOWN  : cntNext = (cnt == DOWN_SIZE) ? 0 : cnt + 1;
            S_EDGE  : cntNext = 0;
            S_UP    : cntNext = (cnt == EP_SIZE) ? 0 : cnt + 1;
        endcase
    end

    // Output value
    always @(*) begin
        case(State)
            S_DOWN  : begin sck = 0; sck_edge = 0; end
            S_EDGE  : begin sck = 1; sck_edge = 1; end
            S_UP    : begin sck = 1; sck_edge = 0; end
        endcase
    end

endmodule

