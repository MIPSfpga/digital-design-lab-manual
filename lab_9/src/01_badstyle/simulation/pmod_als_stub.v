/*
 * Digital Design Lab Manual
 * Lab #9
 *
 * Copyright(c) 2017 Stanislav Zhelnio 
 *
 */

module pmod_als_stub
#(
    parameter value = 8'hAB
)
(
    input             cs,
    input             sck,
    output reg        sdo
);
    wire [7:0]  tvalue  = value;
    wire [15:0] tpacket = { 3'b0, tvalue, 5'b0 };

    reg  [15:0] buffer;

    always @(negedge sck or posedge cs) begin
        if(!cs)
            { sdo, buffer } <= { buffer, 1'b0 };
        else
            { sdo, buffer } <= { 1'b0, tpacket };
    end

endmodule
