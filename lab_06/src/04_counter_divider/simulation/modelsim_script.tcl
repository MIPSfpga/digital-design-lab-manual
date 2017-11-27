# create modelsim working library

vlib work

# compile all the Verilog sources

vlog ../../cnt_div.v
vlog ../cnt_div_tb.v


# open the testbench module for simulation

vsim work.cnt_div_tb

# add all testbench signals to time diagram

# add wave -radix hex sim:/cnt_div_tb/*

add wave -radix bin sim:/cnt_div_tb/clk_in
add wave -radix bin sim:/cnt_div_tb/rst_n
add wave -radix bin sim:/cnt_div_tb/clk_out

# run the simulation

run -all

# expand the signals time diagram

wave zoom full
