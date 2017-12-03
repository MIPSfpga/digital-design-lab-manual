rem recreate a temp folder for all the simulation files

rd /s /q sim
md sim
cd sim

rem compile verilog files for simulation

iverilog -o pwm.out -s pwm_tb ../../pwm.v ../pwm_tb.v

rem run the simulation and finish on $stop

vvp -l pwm.log -n pwm.out

rem show the simulation results in GTKwave

gtkwave dump.vcd

rem return to the parent folder

cd ..
