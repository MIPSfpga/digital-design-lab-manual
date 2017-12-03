#!/usr/bin/env bash
SIM_DIR="sim/"
## Create simulation directory
echo "################################################"
echo "Recreate a temp folder for all simulation files"
echo "################################################"
rm -rf  ${SIM_DIR}
mkdir   ${SIM_DIR}
cd      ${SIM_DIR}


iverilog -o shift_reg.out -s shift_reg_tb ../../shift_reg.v ../shift_reg_tb.v
vvp -l shift_reg.log -n shift_reg.out
gtkwave dump.vcd
