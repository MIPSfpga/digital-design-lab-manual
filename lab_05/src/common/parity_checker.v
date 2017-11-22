module parity_checker
# (
    parameter width = 8
)
(
    input    [ width - 1 : 0 ] x,
    output                     result
);
    wire [ width - 1 : 1 ] t;

    generate
    
        genvar i;
    
        for (i = 1; i <= width - 1; i = i + 1)
        begin : stage
            case (i)
                1         : assign t[i]   = x[1] ^ x[0];
                width - 1 : assign result = x[width - 1] ^ t[i - 1];
                default   : assign t[i]   = x[i] ^ t[i-1];
            endcase
        end
    endgenerate
endmodule
