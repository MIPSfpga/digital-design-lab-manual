create_clock -period "50.0 MHz" [get_ports CLOCK_50]
create_clock -period "50.0 MHz" [get_ports CLOCK2_50]
create_clock -period "50.0 MHz" [get_ports CLOCK3_50]
create_clock -period "50.0 MHz" [get_ports CLOCK4_50]

derive_clock_uncertainty

create_generated_clock -name {clk} -source [get_ports {CLOCK_50}] [get_registers {clk_divider:i_clk_divider|cnt[*]}]

set_false_path -from * -to [get_ports {LEDR[*]}]
set_false_path -from * -to [get_ports {HEX0[*]}]
set_false_path -from * -to [get_ports {HEX1[*]}]
set_false_path -from * -to [get_ports {HEX2[*]}]
set_false_path -from * -to [get_ports {HEX3[*]}]
set_false_path -from * -to [get_ports {HEX4[*]}]
set_false_path -from * -to [get_ports {HEX5[*]}]
set_false_path -from * -to [get_ports {GPIO_0[*]}]
set_false_path -from * -to [get_ports {GPIO_1[*]}]

set_false_path -from [get_ports {KEY[*]}]  -to [all_clocks]
set_false_path -from [get_ports {SW[*]}]   -to [all_clocks]
set_false_path -from [get_ports {GPIO_0[*]}] -to [all_clocks]
set_false_path -from [get_ports {GPIO_1[*]}] -to [all_clocks]
