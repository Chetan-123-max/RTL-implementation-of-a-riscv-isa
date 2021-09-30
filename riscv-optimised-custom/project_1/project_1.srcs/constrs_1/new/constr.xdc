## Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

set_property PACKAGE_PIN U18 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

set_property PACKAGE_PIN U16 [get_ports Tx_Done]
set_property IOSTANDARD LVCMOS33 [get_ports Tx_Done]

set_property PACKAGE_PIN E19 [get_ports Tx_Active]
set_property IOSTANDARD LVCMOS33 [get_ports Tx_Active]

set_property PACKAGE_PIN U19 [get_ports LED]
set_property IOSTANDARD LVCMOS33 [get_ports LED]

set_property PACKAGE_PIN A18 [get_ports Tx]
set_property IOSTANDARD LVCMOS33 [get_ports Tx]

#perfectly synthesised and implemented with 40ns clk
#create_generated_clock -name clk1 -source [get_ports clk] -divide_by 2 [get_pins clk1_reg/Q]
#create_generated_clock -name clk2 -source [get_pins clk1_reg/Q] -divide_by 2 [get_pins clk2_reg/Q]
#create_clock -period 40.000 -name VIRTUAL_clk2 -waveform {0.000 20.000}
#set_input_delay -clock [get_clocks VIRTUAL_clk2] -min -add_delay 3.000 [get_ports rst]
#set_input_delay -clock [get_clocks VIRTUAL_clk2] -max -add_delay 7.000 [get_ports rst]
#set_output_delay -clock [get_clocks VIRTUAL_clk2] -min -add_delay 2.000 [get_ports Tx]
#set_output_delay -clock [get_clocks VIRTUAL_clk2] -max -add_delay 4.000 [get_ports Tx]
#set_output_delay -clock [get_clocks VIRTUAL_clk2] -min -add_delay 2.000 [get_ports Tx_Active]
#set_output_delay -clock [get_clocks VIRTUAL_clk2] -max -add_delay 4.000 [get_ports Tx_Active]

#perfectly synthesised and implemented with 20ns clk
create_generated_clock -name clk1 -source [get_ports clk] -divide_by 2 [get_pins clk1_reg/Q]
create_clock -period 20.000 -name VIRTUAL_clk1 -waveform {0.000 10.000}
set_input_delay -clock [get_clocks VIRTUAL_clk1] -min -add_delay 3.000 [get_ports rst]
set_input_delay -clock [get_clocks VIRTUAL_clk1] -max -add_delay 6.000 [get_ports rst]
set_output_delay -clock [get_clocks VIRTUAL_clk1] -min -add_delay 1.000 [get_ports Tx]
set_output_delay -clock [get_clocks VIRTUAL_clk1] -max -add_delay 2.000 [get_ports Tx]
set_output_delay -clock [get_clocks VIRTUAL_clk1] -min -add_delay 1.000 [get_ports Tx_Active]
set_output_delay -clock [get_clocks VIRTUAL_clk1] -max -add_delay 2.000 [get_ports Tx_Active]
set_output_delay -clock [get_clocks VIRTUAL_clk1] -min -add_delay 0.000 [get_ports LED]
set_output_delay -clock [get_clocks VIRTUAL_clk1] -max -add_delay 0.010 [get_ports LED]

#Didnt perfectly work for 10ns clk
#set_input_delay -clock [get_clocks sys_clk_pin] -min -add_delay 1.500 [get_ports rst]
#set_input_delay -clock [get_clocks sys_clk_pin] -max -add_delay 3.000 [get_ports rst]
#set_output_delay -clock [get_clocks sys_clk_pin] -min -add_delay 0.500 [get_ports Tx]
#set_output_delay -clock [get_clocks sys_clk_pin] -max -add_delay 1.000 [get_ports Tx]
#set_output_delay -clock [get_clocks sys_clk_pin] -min -add_delay 0.500 [get_ports Tx_Active]
#set_output_delay -clock [get_clocks sys_clk_pin] -max -add_delay 1.000 [get_ports Tx_Active]


