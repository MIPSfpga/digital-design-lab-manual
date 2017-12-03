#!/usr/bin/env bash
SIM_DIR=sim/;

echo "################################################"
echo "Recreate a temp folder for all simulation files"
echo "################################################"
rm -rf ${SIM_DIR}
mkdir  ${SIM_DIR}
cd     ${SIM_DIR}


iverilog -o cnt_div.out -s cnt_div_tb ../../cnt_div.v ../cnt_div_tb.v
vvp -l cnt_div.log -n cnt_div.out
gtkwave dump.vcd
