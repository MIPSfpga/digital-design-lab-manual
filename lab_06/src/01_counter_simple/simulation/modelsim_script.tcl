
# create modelsim working library

vlib work

# compile all the Verilog sources

vlog ../../simple_counter.v
vlog ../simple_counter_tb.v

set top=simple_counter_tb
# open the testbench module for simulation

vsim -novopt work.simple_counter_tb

# add all testbench signals to time diagram


add wave -radix bin sim:/simple_counter_tb/clk
add wave -radix bin sim:/simple_counter_tb/rst_n
add wave -radix hex sim:/simple_counter_tb/cnt


# run the simulation

run -all

# expand the signals time diagram

