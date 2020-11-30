# 
# OPENLANE CONFIGURATION FILE
#

# User config
set ::env(DESIGN_NAME) baked_slicel
set ::env(PDK_VARIANT) sky130_fd_sc_hd

set design_root $::env(OPENLANE_ROOT)/designs
set src_root $design_root/250
set clb_root $design_root/250/clb_team
# This is ::env(DESIGN_DIR).
set clb_src $clb_root/src/behavioral
set baked_src $src_root/src/baked
set config_src $src_root/config_team/src/behavioral

# Verilog files for top level RTL connections. Do not include black boxes!
set ::env(VERILOG_FILES) [concat \
    $baked_src/baked_slicel.v \
    $clb_src/slicel.v \
    $clb_src/lut_sXX_softcode.v \
    $clb_src/carry_chain.v \
    $clb_src/mux_f_slice.v \
    $clb_src/lut.v \
    $clb_src/block_config_latches.v \
    [glob $config_src/*.v] \
    ]

# Design config
set ::env(CLOCK_PERIOD) 10
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_NET) $::env(CLOCK_PORT)

set filename $::env(DESIGN_DIR)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}

set ::env(MACRO_PLACEMENT_CFG) $::env(DESIGN_DIR)/macro_placement.cfg

# Synthesis config
set ::env(SYNTH_STRATEGY) 1;
set ::env(SYNTH_LATCH_MAP) 1

# set ::env(FP_SIZING) absolute
# I think this goes LL_X LL_Y UR_X UR_Y, where LL=lower left, UR=upper right
# Units probably microns
# set ::env(DIE_AREA) [list 0 0 700 700]

# Floorplan config
set ::env(FP_CORE_UTIL) 45
# Placement config
set ::env(PL_TARGET_DENSITY) [ expr ($::env(FP_CORE_UTIL)+5) / 100.0 ]

# CTS config
# Routing config
#set ::env(ROUTING_STRATEGY) 14 ;# run TritonRoute14
#set ::env(GLB_RT_ADJUSTMENT) 0
# Flow control config
#
# TODO(aryap): Enable this once the format is clear
# set ::env(FP_PIN_ORDER_CFG) $fabric_src/pin_order.cfg

# # threads for supporting tools
set ::env(ROUTING_CORES) 10

set ::env(PDN_CFG) $::env(DESIGN_DIR)/pdn.tcl
set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg
