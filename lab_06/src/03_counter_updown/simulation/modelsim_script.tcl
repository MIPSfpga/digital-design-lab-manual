# create modelsim working library

vlib work

# compile all the Verilog sources

vlog ../../cnt_updown.v
vlog ../cnt_updown_tb.v


# open the testbench module for simulation

vsim -novopt work.cnt_updown_tb

# add all testbench signals to time diagram

# add wave -radix hex sim:/cnt_updown_tb/*

add wave -radix bin sim:/cnt_updown_tb/clk
add wave -radix bin sim:/cnt_updown_tb/rst_n
add wave -radix bin sim:/cnt_updown_tb/up_down
add wave -radix hex sim:/cnt_updown_tb/cnt
# run the simulation

run -all

# expand the signals time diagram

wave zoom full
