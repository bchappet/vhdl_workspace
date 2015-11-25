### This file is a general .xdc for the Nexys Video Rev. A
### To use it in a project:
### - uncomment the lines corresponding to used pins
### - rename the used ports (in each line, after get_ports) according to the top level signal names in the project


##Clock Signal
set_property PACKAGE_PIN R4 [get_ports CLK]
set_property IOSTANDARD LVCMOS33 [get_ports CLK]
#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK}];

#LEDs
set_property PACKAGE_PIN T14 [get_ports {LED[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED[0]}]
set_property PACKAGE_PIN T15 [get_ports {LED[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED[1]}]
set_property PACKAGE_PIN T16 [get_ports {LED[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED[2]}]
set_property PACKAGE_PIN U16 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED[3]}]
set_property PACKAGE_PIN V15 [get_ports {LED[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED[4]}]
set_property PACKAGE_PIN W16 [get_ports {LED[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED[5]}]
set_property PACKAGE_PIN W15 [get_ports {LED[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED[6]}]
set_property PACKAGE_PIN Y13 [get_ports {LED[7]}]
set_property IOSTANDARD LVCMOS25 [get_ports {LED[7]}]


#reset
set_property PACKAGE_PIN G4 [get_ports RST]



set_property IOSTANDARD LVCMOS18 [get_ports RST]
