# 
# OPENLANE CONFIGURATION FILE
#

# User config
set ::env(DESIGN_NAME) baked_mac_cluster
set ::env(PDK_VARIANT) sky130_fd_sc_hd

set mac_src $::env(OPENLANE_ROOT)/designs/250/mac_team/src
set arithmetic_cells_src $::env(OPENLANE_ROOT)/designs/250/mac_team/arithmetic_cells/src
set config_src $::env(OPENLANE_ROOT)/designs/250/config_team/src/behavioral
set baked_src $::env(OPENLANE_ROOT)/designs/250/src/baked

# Design config
set ::env(CLOCK_PERIOD) 10

set ::env(VERILOG_FILES) [concat \
  $baked_src/baked_mac_cluster.v \
  [glob $config_src/*.v] \
  [glob $mac_src/*.v] \
  [glob $arithmetic_cells_src/*.v] \
  ]

set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_NET) $::env(CLOCK_PORT)

set filename $::env(DESIGN_DIR)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}

# Synthesis config
set ::env(SYNTH_STRATEGY) 2  ;# 1 fails
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
set ::env(SYNTH_MAX_FANOUT) 7

#set ::env(FP_SIZING) absolute
# I think this goes LL_X LL_Y UR_X UR_Y, where LL=lower left, UR=upper right
# Units probably microns
#set ::env(DIE_AREA) [list 0 0 750 570]

set ::env(FP_CORE_UTIL) 30
set ::env(PL_TARGET_DENSITY) 0.35

#set ::env(ROUTING_STRATEGY) 14 ;# run TritonRoute14
#set ::env(GLB_RT_ADJUSTMENT) 0
set ::env(GLB_RT_MAXLAYER) 5

# add_macro_obs \
#	-defFile $::env(CURRENT_DEF) \
#	-lefFile $::env(MERGED_LEF_UNPADDED) \
#	-obstruction core_obs \
#	-placementX 500 \
#	-placementY 500 \
#	-sizeWidth 2200 \
#	-sizeHeight 4300 \
#	-fixed 1 \
#	-layerNames "met5"

# # threads for supporting tools
set ::env(ROUTING_CORES) 4

set ::env(PDN_CFG) $::env(DESIGN_DIR)/pdn.tcl

set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg
