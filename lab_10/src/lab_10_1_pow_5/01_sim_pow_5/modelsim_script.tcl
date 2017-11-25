
# create modelsim working library

vlib work

# compile all the Verilog sources

vlog ../../common/reg*.v
vlog ../../*/pow_5_*.v
vlog ../testbench.v

# open the testbench module for simulation

vsim work.testbench

# add all testbench signals to time diagram

# add wave -radix hex sim:/testbench/*

add wave -radix bin sim:/testbench/clk
add wave -radix bin sim:/testbench/rst_n
add wave -radix bin sim:/testbench/n_vld
add wave -radix hex sim:/testbench/n
add wave -radix bin sim:/testbench/res_vld_pow_5_single_cycle_struct
add wave -radix hex sim:/testbench/res_pow_5_single_cycle_struct
add wave -radix bin sim:/testbench/res_vld_pow_5_en_single_cycle_struct
add wave -radix hex sim:/testbench/res_pow_5_en_single_cycle_struct
add wave -radix bin sim:/testbench/res_vld_pow_5_multi_cycle_struct
add wave -radix hex sim:/testbench/res_pow_5_multi_cycle_struct
add wave -radix bin sim:/testbench/res_vld_pow_5_en_multi_cycle_struct
add wave -radix hex sim:/testbench/res_pow_5_en_multi_cycle_struct
add wave -radix bin {sim:/testbench/res_vld_pow_5_pipe_struct_with_generate_4[0]}
add wave -radix hex {sim:/testbench/res_pow_5_pipe_struct_with_generate_4[7:0]}
add wave -radix bin {sim:/testbench/res_vld_pow_5_en_pipe_struct_with_generate_4[0]}
add wave -radix hex {sim:/testbench/res_pow_5_en_pipe_struct_with_generate_4[7:0]}
add wave -radix bin {sim:/testbench/res_vld_pow_5_pipe_struct_with_generate_5[0]}
add wave -radix hex {sim:/testbench/res_pow_5_pipe_struct_with_generate_5[7:0]}
add wave -radix bin {sim:/testbench/res_vld_pow_5_en_pipe_struct_with_generate_5[0]}
add wave -radix hex {sim:/testbench/res_pow_5_en_pipe_struct_with_generate_5[7:0]}

# run the simulation

run -all

# expand the signals time diagram

wave zoom full
