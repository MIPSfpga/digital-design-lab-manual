#!/usr/bin/env bash
SIM_DIR=sim/;

echo "################################################"
echo "Recreate a temp folder for all simulation files"
echo "################################################"
rm -rf ${SIM_DIR}
mkdir  ${SIM_DIR}
cd     ${SIM_DIR}


iverilog -o cnt_updown.out -s cnt_updown_tb ../../cnt_updown.v ../cnt_updown_tb.v
vvp -l cnt_updown.log -n cnt_updown.out
gtkwave dump.vcd
