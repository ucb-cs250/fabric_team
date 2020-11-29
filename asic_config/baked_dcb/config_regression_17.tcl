
# Design
# 
# OPENLANE CONFIGURATION FILE
#

# User config
set ::env(DESIGN_NAME) baked_data_connection_block
set ::env(PDK_VARIANT) sky130_fd_sc_hd

set design_root $::env(OPENLANE_ROOT)/designs
set src_root $design_root/250
set config_root $src_root/config_team/src/behavioral
set ix_root $src_root/ix_yukio
# This is ::env(DESIGN_DIR).
#set asic_config_root $ix_root/asic_config/dcb
set ix_src $ix_root/src
set baked_src $src_root/src/baked

# Verilog files for top level RTL connections. Do not include black boxes!
set ::env(VERILOG_FILES) [concat \
  $baked_src/baked_data_connection_block.v \
  $ix_src/data_connection_block.v \
  $ix_src/transmission_gate_oneway.v \
  [glob $config_root/*.v] \
]

# Experimental
set ::env(TRISTATE_BUFFER_MAP) $src_root/src/tbuf_map.v

# Design config
set ::env(CLOCK_PERIOD) 10
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_NET) $::env(CLOCK_PORT)

set filename $::env(DESIGN_DIR)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}

# Synthesis config
set ::env(SYNTH_STRATEGY) 1  ;# 1 fails, try 2

set ::env(FP_SIZING) absolute
# I think this goes LL_X LL_Y UR_X UR_Y, where LL=lower left, UR=upper right
# Units probably microns
set ::env(DIE_AREA) [list 0 0 1200 1200]

# Floorplan config
#set ::env(FP_CORE_UTIL) 5
# Placement config
set ::env(PL_TARGET_DENSITY) 0.5

# CTS config
# Routing config
#set ::env(ROUTING_STRATEGY) 14 ;# run TritonRoute14
#set ::env(GLB_RT_ADJUSTMENT) 0
# Flow control config
#
# TODO(aryap): Enable this once the format is clear
# set ::env(FP_PIN_ORDER_CFG) $fabric_src/pin_order.cfg

# # threads for supporting tools
set ::env(ROUTING_CORES) 14

#set ::env(PDN_CFG) $::env(DESIGN_DIR)/pdn.tcl
set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg

# Regression
set ::env(PL_TARGET_DENSITY) 0.507

# Extra
