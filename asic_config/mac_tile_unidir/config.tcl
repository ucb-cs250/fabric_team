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
set mac_design_root $design_root/250_mac
set mac_lef $mac_design_root/runs/$mac_run/results/magic/$mac_top.lef
set mac_gds $mac_design_root/runs/$mac_run/results/magic/$mac_top.gds
set ::env(MAC_TOP) $mac_top

set config_src $src_root/config_team/src/behavioral

set ix_src $src_root/ix_yukio/unidir_src

#set nate_src $src_root/ix_nate
#set nate_lef $nate_src/transmission_gate/std/transmission_gate_cell.lef
#set nate_gds $nate_src/transmission_gate/std/transmission_gate_cell.gds

# Verilog files for top level RTL connections. Do not include black boxes!
set ::env(VERILOG_FILES) [concat \
    $fabric_src/mac_tile.v \
    [glob $config_src/*.v] \
    $ix_src/data_connection_block.v \
    $ix_src/disjoint_switch_box.v \
    $ix_src/switch_box_element_one.v \
    $ix_src/switch_box_element_two.v \
    $ix_src/universal_switch_box.v \
    $mac_src/blackbox/mac_cluster.v \
    ]

puts $::env(VERILOG_FILES)

# Include black boxes!
#set ::env(VERILOG_FILES_BLACKBOX) [list \
#    $mac_src/blackbox/mac_cluster.v \
#    $nate_src/transmission_gate.v \
#  ]

set ::env(TRISTATE_BUFFER_MAP) $src_root/src/tbuf_map.v

set ::env(EXTRA_LEFS) [list $mac_lef]
set ::env(EXTRA_GDS_FILES) [list $mac_gds]

puts $::env(EXTRA_LEFS)
puts $::env(EXTRA_GDS_FILES)

set filename $::env(OPENLANE_ROOT)/designs/250/$::env(PDK)_$::env(PDK_VARIANT)_config.tcl
if { [file exists $filename] == 1} {
  source $filename
}

# set ::env(MACRO_PLACEMENT_CFG) $our_root/macro_placement.cfg

set ::env(CLOCK_PERIOD) 30
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_TREE_SYNTH) 1

set ::env(DIODE_INSERTION_STRATEGY) 0

# This kills openLANE for now.
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 3000 3000"
#set ::env(SYNTH_STRATEGY) 1
#set ::env(SYNTH_READ_BLACKBOX_LIB) 1
#set ::set(SYNTH_FLAT_TOP) 1

#set ::env(FP_CORE_UTIL) 5
set ::env(FP_PDN_VOFFSET) 0
set ::env(FP_PDN_VPITCH) 30

set ::env(PL_TARGET_DENSITY) 0.5
set ::env(PL_BASIC_PLACEMENT) 1
#set ::env(PL_SKIP_INITIAL_PLACEMENT) 1
#set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0

set ::env(ROUTING_STRATEGY) 14 ;# run TritonRoute14
set ::env(GLB_RT_ADJUSTMENT) 0

set ::env(ROUTING_CORES) 10

# TODO(aryap): Enable this once the format is clear
# set ::env(FP_PIN_ORDER_CFG) $fabric_src/pin_order.cfg

set ::env(PDN_CFG) $our_root/pdn.tcl
