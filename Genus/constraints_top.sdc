# =========================================================
# ASYNC FIFO – SDC CONSTRAINT FILE
# =========================================================

# =========================================================
# 1. CLOCK DEFINITIONS
# =========================================================

create_clock -name wclk -period 10 -waveform {0 5} [get_ports wclk]
create_clock -name rclk -period 14 -waveform {0 7} [get_ports rclk]

set_clock_latency 0.2 [get_clocks wclk]
set_clock_latency 0.2 [get_clocks rclk]

set_clock_transition 0.1 [get_clocks wclk]
set_clock_transition 0.1 [get_clocks rclk]

set_clock_uncertainty 0.05 [get_clocks wclk]
set_clock_uncertainty 0.05 [get_clocks rclk]

# =========================================================
# 2. ASYNCHRONOUS CLOCK RELATIONSHIP
# =========================================================

set_clock_groups -asynchronous \
-group [get_clocks wclk] \
-group [get_clocks rclk]

# =========================================================
# 3. RESET PATHS
# =========================================================

set_false_path -from [get_ports wrst_n]
set_false_path -from [get_ports rrst_n]

set_case_analysis 1 [get_ports wrst_n]
set_case_analysis 1 [get_ports rrst_n]

# =========================================================
# 4. INPUT DELAYS
# =========================================================

set_input_delay -max 1.0 -clock wclk [get_ports w_en]
set_input_delay -min 0.2 -clock wclk [get_ports w_en]

set_input_delay -max 1.0 -clock wclk [get_ports {wdata[*]}]
set_input_delay -min 0.2 -clock wclk [get_ports {wdata[*]}]

set_input_delay -max 1.0 -clock rclk [get_ports r_en]
set_input_delay -min 0.2 -clock rclk [get_ports r_en]

# =========================================================
# 5. OUTPUT DELAYS
# =========================================================

set_output_delay -max 1.0 -clock rclk [get_ports {rdata[*]}]
set_output_delay -min 0.2 -clock rclk [get_ports {rdata[*]}]

set_output_delay -max 1.0 -clock wclk [get_ports full]
set_output_delay -min 0.2 -clock wclk [get_ports full]

set_output_delay -max 1.0 -clock rclk [get_ports empty]
set_output_delay -min 0.2 -clock rclk [get_ports empty]

# =========================================================
# 6. CDC SYNCHRONIZER CONSTRAINT
# =========================================================

set_max_delay 0.5 \
-from [get_cells *ff1*] \
-to [get_cells *ff2*]

# =========================================================
# 7. DESIGN RULE CONSTRAINTS
# =========================================================

set_max_transition 0.3 [current_design]
set_max_capacitance 0.2 [current_design]

# =========================================================
# 8. OCV DERATES
# =========================================================

set_timing_derate -late 1.05
set_timing_derate -early 0.95

