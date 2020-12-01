# https://wiki.tcl-lang.org/page/filter
proc filter {list script} {
    set res {}
    foreach e $list {if {[uplevel 1 $script [list $e]]} {lappend res $e}}
    set res
}

proc not_in {list e} {expr {[lsearch -not -exact $list $e]>=0}}

# 
# OPENLANE CONFIGURATION FILE
#
set ::env(DESIGN_NAME) mac_tile
set ::env(PDK_VARIANT) sky130_fd_sc_hd

set design_root $::env(OPENLANE_ROOT)/designs
set src_root $design_root/250
set our_root $src_root/asic_config/mac_tile

set fabric_src $src_root/src
set config_src $src_root/config_team/src/behavioral
set ix_src $src_root/ix_yukio/src
set baked_bb_src $fabric_src/blackbox

#set nate_src $src_root/ix_nate
#set nate_lef $nate_src/transmission_gate/from_inv/transmission_gate_cell.lef
#set nate_gds $nate_src/transmission_gate/from_inv/transmission_gate_cell.gds

set mac_runs $design_root/250/asic_config/baked_mac_cluster
set mac_run {debug}
set mac_lef $mac_runs/runs/$mac_run/results/magic/baked_mac_cluster.lef
set mac_gds $mac_runs/runs/$mac_run/results/magic/baked_mac_cluster.gds

set dcb_runs $design_root/250/asic_config/baked_dcb
set dcb_run {debug}
set dcb_lef $dcb_runs/runs/$dcb_run/results/magic/baked_data_connection_block.lef
set dcb_gds $dcb_runs/runs/$dcb_run/results/magic/baked_data_connection_block.gds

set dsb_runs $design_root/250/asic_config/baked_dsb
set dsb_run {700_700_0.4}
set dsb_lef $dsb_runs/runs/$dsb_run/results/magic/baked_disjoint_switch_box.lef
set dsb_gds $dsb_runs/runs/$dsb_run/results/magic/baked_disjoint_switch_box.gds

# Verilog files for top level RTL connections. Do not include black boxes!
set ::env(VERILOG_FILES) [concat \
  $fabric_src/mac_tile.v \
  $baked_bb_src/baked_data_connection_block.v \
  $baked_bb_src/baked_disjoint_switch_box.v \
  $baked_bb_src/baked_mac_cluster.v \
]

set ::env(TRISTATE_BUFFER_MAP) $src_root/src/tbuf_map.v

set ::env(EXTRA_LEFS) [list $mac_lef $dcb_lef $dsb_lef]
set ::env(EXTRA_GDS_FILES) [list $mac_gds $dcb_gds $dcb_lef]

set filename $::env(OPENLANE_ROOT)/designs/250/$::env(PDK)_$::env(PDK_VARIANT)_config.tcl
if { [file exists $filename] == 1} {
  source $filename
}

set ::env(MACRO_PLACEMENT_CFG) $our_root/macro_placement.cfg

set ::env(CLOCK_PERIOD) 30
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_TREE_SYNTH) 1

set ::env(DIODE_INSERTION_STRATEGY) 0

# This kills openLANE for now.
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 2100 2200"
#set ::env(SYNTH_STRATEGY) 1
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
#set ::set(SYNTH_FLAT_TOP) 1

#set ::env(FP_CORE_UTIL) 50
set ::env(FP_PDN_VOFFSET) 0
set ::env(FP_PDN_VPITCH) 30

# This was the finest I could tune the parameter, but it still failed.
set ::env(PL_TARGET_DENSITY) 0.00000377

# These were set to attempt to skip global placement, which we don't seem to be
# able to satisfy with only 4 cells to move around.
set ::env(PL_BASIC_PLACEMENT) 0
set ::env(PL_SKIP_INITIAL_PLACEMENT) 1

set ::env(PL_RANDOM_GLB_PLACEMENT) 0

#set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0

#set ::env(GLB_RT_ADJUSTMENT) 0

set ::env(ROUTING_CORES) 10

set ::env(FP_PIN_ORDER_CFG) $our_root/pin_order.cfg

set ::env(PDN_CFG) $our_root/pdn.tcl
