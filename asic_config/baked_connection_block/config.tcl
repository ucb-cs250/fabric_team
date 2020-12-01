# 
# OPENLANE CONFIGURATION FILE
#

# This config should be included in macros for the _east and _north versions
# for this block. It contains the params that last work when synthesising the
# block as-is.

# User config
set ::env(DESIGN_NAME) baked_connection_block
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
    $baked_src/baked_connection_block.v \
    $ix_src/connection_block.v \
    $ix_src/transmission_gate_oneway.v \
    $ix_src/transmission_gate.v \
    $ix_src/switch_box_element_two.v \
    $ix_src/universal_switch_box.v \
    $nate_src/../std/transmission_gate_cell.v \
    [glob $config_src/*.v] \
    ]

set ::env(EXTRA_LEFS) [list $nate_lef]
set ::env(EXTRA_GDS_FILES) [list $nate_gds]

set ::env(CLOCK_PERIOD) 10
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_NET) $::env(CLOCK_PORT)

set filename $::env(DESIGN_DIR)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}

set ::env(MACRO_PLACEMENT_CFG) $::env(DESIGN_DIR)/macro_placement.cfg

set ::env(SYNTH_STRATEGY) 1;# 1 fails

set ::env(FP_CORE_UTIL) 40
set ::env(PL_TARGET_DENSITY) [ expr ($::env(FP_CORE_UTIL)+5) / 100.0 ]

set ::env(ROUTING_CORES) 10

set ::env(PDN_CFG) $::env(DESIGN_DIR)/pdn.tcl
set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg
