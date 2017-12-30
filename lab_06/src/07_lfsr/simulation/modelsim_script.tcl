
# create modelsim working library

vlib work

# compile all the Verilog sources

vlog ../../shift_reg.v
vlog ../shift_reg_tb.v

set top=shift_reg_tb
# open the testbench module for simulation

vsim -novopt work.shift_reg_tb

# add all testbench signals to time diagram


add wave -radix bin sim:/shift_reg_tb/clk
add wave -radix bin sim:/shift_reg_tb/rst_n
add wave -radix bin sim:/shift_reg_tb/data_in
add wave -radix bin sim:/shift_reg_tb/shift_en
add wave -radix hex sim:/shift_reg_tb/data_out
add wave -radix bin sim:/shift_reg_tb/serial_out
# run the simulation

run -all

# expand the signals time diagram

