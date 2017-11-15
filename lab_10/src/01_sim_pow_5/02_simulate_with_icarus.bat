rd /s /q sim
md sim
cd sim

iverilog -s testbench ..\testbench.v ..\..\lab1.v 
vvp -la.lst -n a.out -vcd

gtkwave dump.vcd
cd ..
