rem recreate a temp folder for all the simulation files

rd /s /q sim
md sim
cd sim

rem compile verilog files for simulation

iverilog -o cnt_div.out -s cnt_div_tb ../../cnt_div.v ../cnt_div_tb.v

rem run the simulation and finish on $stop

vvp -l cnt_div.log -n cnt_div.out

rem show the simulation results in GTKwave

gtkwave dump.vcd

rem return to the parent folder

cd ..
