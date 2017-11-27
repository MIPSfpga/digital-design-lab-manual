#!/usr/bin/env bash
SIM_DIR=sim/
## Create simulation directory
echo "################################################"
echo "Recreate a temp folder for all simulation files"
echo "################################################"
rm -rf  ${SIM_DIR}
mkdir   ${SIM_DIR}
cd      ${SIM_DIR}


iverilog -o simple_counter.out -s simple_counter_tb ../../simple_counter.v ../simple_counter_tb.v
vvp -l simple_counter.log -n simple_counter.out
gtkwave dump.vcd
