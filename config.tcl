# 
# OPENLANE CONFIGURATION FILE
#

# User config
set ::env(DESIGN_NAME) fpga_250
set ::env(PDK_VARIANT) sky130_fd_sc_hd

set design_root $::env(OPENLANE_ROOT)/designs
set src_root $design_root/250

set fabric_src $src_root/src

set mac_top mac_cluster
set mac_run cluster_700_650
set mac_src $src_root/mac_team/src
set mac_design_root $design_root/mac_hardened_absolute
set mac_lef $mac_design_root/runs/$mac_run/results/magic/$mac_top.lef
set mac_gds $mac_design_root/runs/$mac_run/results/magic/$mac_top.gds
set ::env(MAC_TOP) $mac_top

set ::env(VERILOG_FILES) [concat \
    [glob $fabric_src/*.v] \
    [glob $mac_src/*.v]]
set ::env(VERILOG_FILES_BLACKBOX) [concat \
    [glob $mac_src/*.v]]
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

set ::env(EXTRA_LEFS) [list $mac_lef]
set ::env(EXTRA_GDS_FILES) [list $mac_gds]

# set ::set(SYNTH_FLAT_TOP) 1

set ::env(CLOCK_PORT) "clk"

set filename $::env(OPENLANE_ROOT)/designs/250/$::env(PDK)_$::env(PDK_VARIANT)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}

# Design config
set ::env(CLOCK_PERIOD) 30
# Synthesis config
set ::env(SYNTH_STRATEGY) 1
# Floorplan config
set ::env(FP_CORE_UTIL) 5
# Placement config
set ::env(PL_TARGET_DENSITY) 0.5
# CTS config
# Routing config
set ::env(ROUTING_STRATEGY) 14 ;# run TritonRoute14
set ::env(GLB_RT_ADJUSTMENT) 0
# Flow control config

# # threads for supporting tools
set ::env(ROUTING_CORES) 4
