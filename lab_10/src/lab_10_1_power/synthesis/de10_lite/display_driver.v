module display_driver
(
    input      [3:0] number,
    output reg [6:0] abcdefg
);

    // a b c d e f g .   // Letter from scheme below
    // 0 1 2 3 4 5 6 7   // Bit in hex0

    //   --a--
    //  |     |
    //  f     b
    //  |     |
    //   --g--
    //  |     |
    //  e     c
    //  |     |
    //   --d-- 

    always @*
        case (number)
        4'h0: abcdefg = 7'b1000000;
        4'h1: abcdefg = 7'b1111001;
        4'h2: abcdefg = 7'b0100100;
        4'h3: abcdefg = 7'b0110000;
        4'h4: abcdefg = 7'b0011001;
        4'h5: abcdefg = 7'b0010010;
        4'h6: abcdefg = 7'b0000010;
        4'h7: abcdefg = 7'b1111000;
        4'h8: abcdefg = 7'b0000000;
        4'h9: abcdefg = 7'b0010000;
        4'ha: abcdefg = 7'b0001000;
        4'hb: abcdefg = 7'b0000011;
        4'hc: abcdefg = 7'b1000110;
        4'hd: abcdefg = 7'b0100001;
        4'he: abcdefg = 7'b0000110;
        4'hf: abcdefg = 7'b0001110;
        endcase

endmodule
