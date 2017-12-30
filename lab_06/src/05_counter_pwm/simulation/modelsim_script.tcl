
# create modelsim working library

vlib work

# compile all the Verilog sources

vlog ../../pwm.v
vlog ../pwm_tb.v

set top=pwm_tb
# open the testbench module for simulation

vsim -novopt work.pwm_tb

# add all testbench signals to time diagram


add wave -radix bin sim:/pwm_tb/clk
add wave -radix bin sim:/pwm_tb/rst_n
add wave -radix hex sim:/pwm_tb/imp_width
add wave -radix bin sim:/pwm_tb/pwm_out



# run the simulation

run -all

# expand the signals time diagram

