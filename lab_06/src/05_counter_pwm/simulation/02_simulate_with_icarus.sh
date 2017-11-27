#!/usr/bin/env bash
SIM_DIR=sim/;
## Create simulation directory
echo "################################################"
echo "Recreate a temp folder for all simulation files"
echo "################################################"
rm -rf  ${SIM_DIR}
mkdir   ${SIM_DIR}
cd      ${SIM_DIR}


iverilog -o pwm.out -s pwm_tb ../../pwm.v ../pwm_tb.v
vvp -l pwm.log -n pwm.out
gtkwave dump.vcd
