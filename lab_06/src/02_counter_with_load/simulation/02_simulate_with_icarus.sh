#!/usr/bin/env bash
SIM_DIR=sim/;
## Create simulation directory
echo "Remove sim"
rm -rf ${SIM_DIR}
mkdir  ${SIM_DIR}
cd     ${SIM_DIR}


iverilog -o cnt_load.out -s cnt_load_tb ../../cnt_load.v ../cnt_load_tb.v
vvp -l cnt_load.log -n cnt_load.out
gtkwave dump.vcd
