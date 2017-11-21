create_clock -period "10.0 MHz" [get_ports ADC_CLK_10]
create_clock -period "50.0 MHz" [get_ports MAX10_CLK1_50]
create_clock -period "50.0 MHz" [get_ports MAX10_CLK2_50]

derive_clock_uncertainty

# create_generated_clock -name {clk} -source [get_ports {MAX10_CLK1_50}] [get_registers {clk_divider:i_clk_divider|cnt[*]}]

set_false_path -from [get_ports {KEY[*]}]  -to *
set_false_path -from [get_ports {SW[*]}]   -to *

set_false_path -from * -to [get_ports {LEDR[*]}]
