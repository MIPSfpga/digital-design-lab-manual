module de2_115
(
  input        CLOCK_50,
  input [1:0]  KEY,
 
  input [0:0]  SW,
 
  output [7:0] LEDR,
  output [0:0] LEDG,
 
  output [6:0] HEX1,
  output [6:0] HEX0
);

   localparam CNT_W = 8;
   
   wire               clk_slow;
   wire               clk_global;
   wire [CNT_W - 1:0] cnt_to_seg7;
   
   assign LEDR = cnt_to_seg7;
   
 //Set WIDTH=18 for demostration this example
   clk_divider #(.WIDTH(25)) clk_div
   ( 
     .clk_in  ( CLOCK_50 ),
     .rst_n   ( KEY[0]   ),
     .clk_out ( clk_slow )
   );
   
   global glob_net
   (
     .in ( clk_slow   ),
     .out( clk_global )
   );

   shift_reg #(.WIDTH(CNT_W)) shift_inst
   (
      .clk       ( clk_global  ),
      .rst_n     ( KEY[0]      ),
      .data_in   ( KEY[1]      ),
      .shift_en  ( SW          ),
      .data_out  ( cnt_to_seg7 ),
      .serial_out( LEDG        )
   );
   
 
   led7 #(.COUNT(2)) led7_4
   (
    .data(cnt_to_seg7),
    .leds({HEX1,HEX0})
   );
  
                          
endmodule
