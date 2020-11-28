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

set mac_top mac_cluster
set mac_run {cluster_new_650_650_0.3}
set mac_src $src_root/mac_team/src
set mac_lef $src_root/mac_team/gds_files/latest/mac_cluster.lef
set mac_gds $src_root/mac_team/gds_files/latest/mac_cluster.gds
#set mac_design_root $design_root/250_mac
#set mac_lef $mac_design_root/runs/$mac_run/results/magic/$mac_top.lef
#set mac_gds $mac_design_root/runs/$mac_run/results/magic/$mac_top.gds
set ::env(MAC_TOP) $mac_top

set config_src $src_root/config_team/src/behavioral

set ix_src $src_root/ix_yukio/src
set ix_runs $design_root/250/ix_yukio/asic_config

#set nate_src $src_root/ix_nate
#set nate_lef $nate_src/transmission_gate/from_inv/transmission_gate_cell.lef
#set nate_gds $nate_src/transmission_gate/from_inv/transmission_gate_cell.gds

set ix_dcb_lef $ix_runs/dcb/runs/debug_650_650_0.5/results/magic/data_connection_block.lef
set ix_dcb_gds $ix_runs/dcb/runs/debug_650_650_0.5/results/magic/data_connection_block.gds

set ix_dsb_lef $ix_runs/dsb/runs/194_650_650_0.3/results/magic/disjoint_switch_box.lef
set ix_dsb_gds $ix_runs/dsb/runs/194_650_650_0.3/results/magic/disjoint_switch_box.gds

# Verilog files for top level RTL connections. Do not include black boxes!
set ::env(VERILOG_FILES) [concat \
    $fabric_src/mac_tile.v \
    [glob $config_src/*.v] \
    $ix_src/blackbox/data_connection_block.v \
    $ix_src/blackbox/disjoint_switch_box.v \
    $mac_src/blackbox/mac_cluster.v \
    ]

# Include black boxes!
#set ::env(VERILOG_FILES_BLACKBOX) [list \
#    $mac_src/blackbox/mac_cluster.v \
#    $nate_src/transmission_gate.v \
#  ]

set ::env(TRISTATE_BUFFER_MAP) $src_root/src/tbuf_map.v

set ::env(EXTRA_LEFS) [list $mac_lef $ix_dcb_lef $ix_dsb_lef]
set ::env(EXTRA_GDS_FILES) [list $mac_gds $ix_dcb_gds $ix_dcb_lef]

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
set ::env(DIE_AREA) "0 0 2500 2500"
#set ::env(SYNTH_STRATEGY) 1
#set ::env(SYNTH_READ_BLACKBOX_LIB) 1
#set ::set(SYNTH_FLAT_TOP) 1

#set ::env(FP_CORE_UTIL) 50
set ::env(FP_PDN_VOFFSET) 0
set ::env(FP_PDN_VPITCH) 30

set ::env(PL_TARGET_DENSITY) 0.30
set ::env(PL_BASIC_PLACEMENT) 1
#set ::env(PL_SKIP_INITIAL_PLACEMENT) 1
#set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0

set ::env(GLB_RT_ADJUSTMENT) 0

set ::env(ROUTING_CORES) 10

set ::env(FP_PIN_ORDER_CFG) $our_root/pin_order.cfg

set ::env(PDN_CFG) $our_root/pdn.tcl
