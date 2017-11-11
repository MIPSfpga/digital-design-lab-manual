module top
(
    input         clock,
    input         reset_n,
    input  [ 3:0] key,
    input  [ 7:0] sw,
    output [ 7:0] led,
    output [31:0] disp
);

    assign led  = sw;
    assign disp = { sw, sw, sw, key, key };    

endmodule
