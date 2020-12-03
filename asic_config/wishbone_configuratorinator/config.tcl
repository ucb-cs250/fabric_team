# 
# OPENLANE CONFIGURATION FILE
#

# User config
set ::env(DESIGN_NAME) wishbone_configuratorinator
set ::env(PDK_VARIANT) sky130_fd_sc_hd

set design_root $::env(OPENLANE_ROOT)/designs
set src_root $design_root/250
# This is ::env(DESIGN_DIR).
set config_src $src_root/config_team/src/behavioral

# Verilog files for top level RTL connections. Do not include black boxes!
set ::env(VERILOG_FILES) [concat \
    $config_src/wishbone_configuratorinator.v \
    ]

# Design config
set ::env(CLOCK_PERIOD) 10
set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_NET) $::env(CLOCK_PORT)

set filename $::env(DESIGN_DIR)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}

set ::env(MACRO_PLACEMENT_CFG) $::env(DESIGN_DIR)/macro_placement.cfg

# Synthesis config
set ::env(SYNTH_STRATEGY) 1

# Floorplan config
set ::env(FP_ASPECT_RATIO) 0.25
set ::env(FP_CORE_UTIL) 40
# Placement config
set ::env(PL_TARGET_DENSITY) 0.45

# threads for supporting tools
set ::env(ROUTING_CORES) 10

set ::env(PDN_CFG) $::env(DESIGN_DIR)/pdn.tcl
set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg
