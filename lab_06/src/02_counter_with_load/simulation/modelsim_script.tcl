# create modelsim working library

vlib work

# compile all the Verilog sources

vlog ../../cnt_load.v
vlog ../cnt_load_tb.v


# open the testbench module for simulation

vsim work.cnt_load_tb

# add all testbench signals to time diagram

# add wave -radix hex sim:/cnt_load_tb/*

add wave -radix bin sim:/cnt_load_tb/clk
add wave -radix bin sim:/cnt_load_tb/rst_n
add wave -radix bin sim:/cnt_load_tb/load
add wave -radix hex sim:/cnt_load_tb/data_load
add wave -radix hex sim:/cnt_load_tb/cnt
# run the simulation

run -all

# expand the signals time diagram

wave zoom full
