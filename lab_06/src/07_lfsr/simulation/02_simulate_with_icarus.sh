#!/usr/bin/env bash
SIM_DIR="sim/"
## Create simulation directory
echo "################################################"
echo "Recreate a temp folder for all simulation files"
echo "################################################"
rm -rf  ${SIM_DIR}
mkdir   ${SIM_DIR}
cd      ${SIM_DIR}


iverilog -o lfsr.out -s lfsr_tb ../../lfsr.v ../lfsr_tb.v
vvp -l lfsr.log -n lfsr.out
gtkwave dump.vcd
