# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.14-s082_1 on Fri Mar 13 16:45:38 IST 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design async_fifo

set_case_analysis 1 [get_ports rrst_n]
set_case_analysis 1 [get_ports wrst_n]
create_clock -name "wclk" -period 10.0 -waveform {0.0 5.0} [get_ports wclk]
create_clock -name "rclk" -period 14.0 -waveform {0.0 7.0} [get_ports rclk]
set_clock_transition 0.1 [get_clocks wclk]
set_clock_transition 0.1 [get_clocks rclk]
set_false_path -from [list \
  [get_ports wrst_n]  \
  [get_ports rrst_n] ]
set_max_delay 0.5 -from [list \
  [get_cells {rgray_wclk_ff1_reg[0]}]  \
  [get_cells {rgray_wclk_ff1_reg[1]}]  \
  [get_cells {rgray_wclk_ff1_reg[2]}]  \
  [get_cells {rgray_wclk_ff1_reg[3]}]  \
  [get_cells {wgray_rclk_ff1_reg[0]}]  \
  [get_cells {wgray_rclk_ff1_reg[1]}]  \
  [get_cells {wgray_rclk_ff1_reg[2]}]  \
  [get_cells {wgray_rclk_ff1_reg[3]}] ] -to [list \
  [get_cells {rgray_wclk_ff2_reg[0]}]  \
  [get_cells {rgray_wclk_ff2_reg[1]}]  \
  [get_cells {rgray_wclk_ff2_reg[2]}]  \
  [get_cells {rgray_wclk_ff2_reg[3]}]  \
  [get_cells {wgray_rclk_ff2_reg[0]}]  \
  [get_cells {wgray_rclk_ff2_reg[1]}]  \
  [get_cells {wgray_rclk_ff2_reg[2]}]  \
  [get_cells {wgray_rclk_ff2_reg[3]}] ]
set_clock_groups -name "clock_groups_wclk_to_rclk" -asynchronous -group [get_clocks wclk] -group [get_clocks rclk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks wclk] -add_delay -max 1.0 [get_ports w_en]
set_input_delay -clock [get_clocks wclk] -add_delay -min 0.2 [get_ports w_en]
set_input_delay -clock [get_clocks wclk] -add_delay -max 1.0 [get_ports {wdata[7]}]
set_input_delay -clock [get_clocks wclk] -add_delay -max 1.0 [get_ports {wdata[6]}]
set_input_delay -clock [get_clocks wclk] -add_delay -max 1.0 [get_ports {wdata[5]}]
set_input_delay -clock [get_clocks wclk] -add_delay -max 1.0 [get_ports {wdata[4]}]
set_input_delay -clock [get_clocks wclk] -add_delay -max 1.0 [get_ports {wdata[3]}]
set_input_delay -clock [get_clocks wclk] -add_delay -max 1.0 [get_ports {wdata[2]}]
set_input_delay -clock [get_clocks wclk] -add_delay -max 1.0 [get_ports {wdata[1]}]
set_input_delay -clock [get_clocks wclk] -add_delay -max 1.0 [get_ports {wdata[0]}]
set_input_delay -clock [get_clocks wclk] -add_delay -min 0.2 [get_ports {wdata[7]}]
set_input_delay -clock [get_clocks wclk] -add_delay -min 0.2 [get_ports {wdata[6]}]
set_input_delay -clock [get_clocks wclk] -add_delay -min 0.2 [get_ports {wdata[5]}]
set_input_delay -clock [get_clocks wclk] -add_delay -min 0.2 [get_ports {wdata[4]}]
set_input_delay -clock [get_clocks wclk] -add_delay -min 0.2 [get_ports {wdata[3]}]
set_input_delay -clock [get_clocks wclk] -add_delay -min 0.2 [get_ports {wdata[2]}]
set_input_delay -clock [get_clocks wclk] -add_delay -min 0.2 [get_ports {wdata[1]}]
set_input_delay -clock [get_clocks wclk] -add_delay -min 0.2 [get_ports {wdata[0]}]
set_input_delay -clock [get_clocks rclk] -add_delay -max 1.0 [get_ports r_en]
set_input_delay -clock [get_clocks rclk] -add_delay -min 0.2 [get_ports r_en]
set_output_delay -clock [get_clocks rclk] -add_delay -max 1.0 [get_ports {rdata[7]}]
set_output_delay -clock [get_clocks rclk] -add_delay -max 1.0 [get_ports {rdata[6]}]
set_output_delay -clock [get_clocks rclk] -add_delay -max 1.0 [get_ports {rdata[5]}]
set_output_delay -clock [get_clocks rclk] -add_delay -max 1.0 [get_ports {rdata[4]}]
set_output_delay -clock [get_clocks rclk] -add_delay -max 1.0 [get_ports {rdata[3]}]
set_output_delay -clock [get_clocks rclk] -add_delay -max 1.0 [get_ports {rdata[2]}]
set_output_delay -clock [get_clocks rclk] -add_delay -max 1.0 [get_ports {rdata[1]}]
set_output_delay -clock [get_clocks rclk] -add_delay -max 1.0 [get_ports {rdata[0]}]
set_output_delay -clock [get_clocks rclk] -add_delay -min 0.2 [get_ports {rdata[7]}]
set_output_delay -clock [get_clocks rclk] -add_delay -min 0.2 [get_ports {rdata[6]}]
set_output_delay -clock [get_clocks rclk] -add_delay -min 0.2 [get_ports {rdata[5]}]
set_output_delay -clock [get_clocks rclk] -add_delay -min 0.2 [get_ports {rdata[4]}]
set_output_delay -clock [get_clocks rclk] -add_delay -min 0.2 [get_ports {rdata[3]}]
set_output_delay -clock [get_clocks rclk] -add_delay -min 0.2 [get_ports {rdata[2]}]
set_output_delay -clock [get_clocks rclk] -add_delay -min 0.2 [get_ports {rdata[1]}]
set_output_delay -clock [get_clocks rclk] -add_delay -min 0.2 [get_ports {rdata[0]}]
set_output_delay -clock [get_clocks wclk] -add_delay -max 1.0 [get_ports full]
set_output_delay -clock [get_clocks wclk] -add_delay -min 0.2 [get_ports full]
set_output_delay -clock [get_clocks rclk] -add_delay -max 1.0 [get_ports empty]
set_output_delay -clock [get_clocks rclk] -add_delay -min 0.2 [get_ports empty]
set_max_fanout 20.000 [current_design]
set_max_transition 0.3 [current_design]
set_max_capacitance 0.2 [current_design]
set_wire_load_mode "enclosed"
set_clock_latency  0.2 [get_clocks wclk]
set_clock_uncertainty -setup 0.05 [get_clocks wclk]
set_clock_uncertainty -hold 0.05 [get_clocks wclk]
set_clock_latency  0.2 [get_clocks rclk]
set_clock_uncertainty -setup 0.05 [get_clocks rclk]
set_clock_uncertainty -hold 0.05 [get_clocks rclk]
