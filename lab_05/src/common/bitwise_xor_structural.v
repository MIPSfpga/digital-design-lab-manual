module bitwise_xor_structural
# (
    parameter width = 8
)
(
    input    [ width - 1 : 0 ] x, y
    output   [ width - 1 : 0 ] result
);
    
    generate
    
        genvar i;
    
        for (i = 1; i <= width - 1; i = i + 1)
        begin : stage
            xor( result[i], x[i], y[i] );
        end
    endgenerate
endmodule
