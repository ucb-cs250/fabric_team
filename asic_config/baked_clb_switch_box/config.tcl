# 
# OPENLANE CONFIGURATION FILE
#

# User config
set ::env(DESIGN_NAME) baked_clb_switch_box
set ::env(PDK_VARIANT) sky130_fd_sc_hd

set design_root $::env(OPENLANE_ROOT)/designs
set src_root $design_root/250
set ix_root $design_root/250/ix_yukio
# This is ::env(DESIGN_DIR).
set ix_src $ix_root/src
set baked_src $src_root/src/baked
set config_src $src_root/config_team/src/behavioral

set nate_src $src_root/ix_nate/transmission_gate/from_inv
set nate_lef $nate_src/transmission_gate_cell.lef
set nate_gds $nate_src/transmission_gate_cell.gds

# Verilog files for top level RTL connections. Do not include black boxes!
set ::env(VERILOG_FILES) [concat \
    $baked_src/baked_clb_switch_box.v \
    $ix_src/clb_switch_box.v \
    $ix_src/transmission_gate_oneway.v \
    $ix_src/transmission_gate.v \
    $ix_src/switch_box_element_two.v \
    $ix_src/universal_switch_box.v \
    $nate_src/../std/transmission_gate_cell.v \
    [glob $config_src/*.v] \
    ]

set ::env(EXTRA_LEFS) [list $nate_lef]
set ::env(EXTRA_GDS_FILES) [list $nate_gds]

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
set ::env(SYNTH_STRATEGY) 1;# 1 fails

# Experimental Tristates
set ::env(TRISTATE_BUFFER_MAP) $src_root/src/tbuf_map.v
set ::env(SYNTH_MUX_MAP) $src_root/src/mux_map.v

# set ::env(FP_SIZING) absolute
# I think this goes LL_X LL_Y UR_X UR_Y, where LL=lower left, UR=upper right
# Units probably microns
# set ::env(DIE_AREA) [list 0 0 700 700]

# Floorplan config
set ::env(FP_CORE_UTIL) 40
# Placement config
set ::env(PL_TARGET_DENSITY) [ expr ($::env(FP_CORE_UTIL)+5) / 100.0 ]

set ::env(USE_ARC_ANTENNA_CHECK) 0

#set ::env(ROUTING_STRATEGY) 14 ;# run TritonRoute14
#set ::env(GLB_RT_ADJUSTMENT) 0

# # threads for supporting tools
set ::env(ROUTING_CORES) 10

set ::env(PDN_CFG) $::env(DESIGN_DIR)/pdn.tcl
set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg
