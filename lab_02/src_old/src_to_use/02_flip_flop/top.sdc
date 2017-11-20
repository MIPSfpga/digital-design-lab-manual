#create_clock -period "50 MHz" [get_ports {clock}               ]
create_clock -period 1000     [get_ports {key[3]}]

#create_clock -period 1000     [get_nets  {key[0]~inputclkctrl} ]
#create_clock -period "1 MHz"  [get_nets  {counter[24]~clkctrl} ]

set_false_path -from [get_ports {key[*]}] -to [ all_clocks       ]
set_false_path -from *                    -to [ get_ports led[*] ]
