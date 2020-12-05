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
set ::env(DESIGN_NAME) clb_tile
set ::env(PDK_VARIANT) sky130_fd_sc_hd

set design_root $::env(OPENLANE_ROOT)/designs
set src_root $design_root/250
set our_root $src_root/asic_config/clb_tile

set fabric_src $src_root/src
set config_src $src_root/config_team/src/behavioral
set ix_src $src_root/ix_yukio/src
set baked_bb_src $fabric_src/blackbox
set baked_src $fabric_src/baked

set nate_src $src_root/ix_nate
#set nate_lef $nate_src/transmission_gate/from_inv/transmission_gate_cell.lef
#set nate_gds $nate_src/transmission_gate/from_inv/transmission_gate_cell.gds

set use_debug_products false

# baked_slicel
if {$use_debug_products} {
  set slicel_runs $design_root/250/asic_config/baked_slicel
  set slicel_run {debug}
  set slicel_lef $slicel_runs/runs/$slicel_run/results/magic/baked_slicel.lef
  set slicel_gds $slicel_runs/runs/$slicel_run/results/magic/baked_slicel.gds

  # baked_connection_block_north
  set cb_n_runs $design_root/250/asic_config/baked_connection_block_north
  set cb_n_run {debug}
  set cb_n_lef $cb_n_runs/runs/$cb_n_run/results/magic/baked_connection_block_north.lef
  set cb_n_gds $cb_n_runs/runs/$cb_n_run/results/magic/baked_connection_block_north.gds

  # baked_connection_block_east
  set cb_e_runs $design_root/250/asic_config/baked_connection_block_east
  set cb_e_run {debug}
  set cb_e_lef $cb_e_runs/runs/$cb_e_run/results/magic/baked_connection_block_east.lef
  set cb_e_gds $cb_e_runs/runs/$cb_e_run/results/magic/baked_connection_block_east.gds

  # baked_clb_switch_box
  set sb_runs $design_root/250/asic_config/baked_clb_switch_box 
  set sb_run {debug}
  set sb_lef $sb_runs/runs/$sb_run/results/magic/baked_clb_switch_box.lef
  set sb_gds $sb_runs/runs/$sb_run/results/magic/baked_clb_switch_box.gds
} else {
  set gds_root $src_root/gds

  set slicel_lef $gds_root/baked_slicel/baked_slicel.lef
  set slicel_gds $gds_root/baked_slicel/baked_slicel.gds

  set cb_n_lef $gds_root/baked_connection_block_north/baked_connection_block_north.lef
  set cb_n_gds $gds_root/baked_connection_block_north/baked_connection_block_north.gds

  set cb_e_lef $gds_root/baked_connection_block_east/baked_connection_block_east.lef
  set cb_e_gds $gds_root/baked_connection_block_east/baked_connection_block_east.gds

  set sb_lef $gds_root/baked_clb_switch_box/baked_clb_switch_box.lef
  set sb_gds $gds_root/baked_clb_switch_box/baked_clb_switch_box.gds
}

# Experimental Tristates
set ::env(TRISTATE_BUFFER_MAP) $src_root/src/tbuf_map.v
set ::env(SYNTH_MUX_MAP) $src_root/src/mux_map.v

# Verilog files for top level RTL connections. Do not include black boxes!
set ::env(VERILOG_FILES) [concat \
  $fabric_src/clb_tile.v \
  $baked_src/baked_connection_block_north.v \
  $baked_src/baked_connection_block_east.v \
  $baked_src/baked_connection_block.v \
  $baked_bb_src/baked_clb_switch_box.v \
  $baked_bb_src/baked_slicel.v \
  $ix_src/connection_block.v \
  $ix_src/transmission_gate_oneway.v \
  $ix_src/transmission_gate.v \
  $ix_src/switch_box_element_two.v \
  $ix_src/universal_switch_box.v \
  [glob $config_src/*.v] \
]

set ::env(TRISTATE_BUFFER_MAP) $src_root/src/tbuf_map.v

set ::env(EXTRA_LEFS) [list $slicel_lef $cb_n_lef $cb_e_lef $sb_lef]
set ::env(EXTRA_GDS_FILES) [list $slicel_gds $cb_n_gds $cb_e_gds $sb_gds]

set filename $::env(OPENLANE_ROOT)/designs/250/$::env(PDK)_$::env(PDK_VARIANT)_config.tcl
if { [file exists $filename] == 1} {
  source $filename
}

set ::env(MACRO_PLACEMENT_CFG) $our_root/macro_placement.cfg

set ::env(CLOCK_PERIOD) 20
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_TREE_SYNTH) 1

set ::env(SYNTH_READ_BLACKBOX_LIB) 1

set ::env(FP_SIZING) "absolute"
set ::env(DIE_AREA) [list 0.0 0.0 700.0 700.0]
# Halo around the Macros
set ::env(FP_HORIZONTAL_HALO) 25
set ::env(FP_VERTICAL_HALO) 25
#set ::env(FP_CORE_UTIL) 30
#set ::env(FP_PDN_VOFFSET) 0
#set ::env(FP_PDN_VPITCH) 30

set ::env(PL_TARGET_DENSITY) 0.4

# These were set to attempt to skip global placement, which we don't seem to be
# able to satisfy with only 4 cells to move around.
# set ::env(PL_BASIC_PLACEMENT) 0
#set ::env(PL_SKIP_INITIAL_PLACEMENT) 1
#set ::env(PL_RANDOM_GLB_PLACEMENT) 1
#
#set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0

#set ::env(GLB_RT_ADJUSTMENT) 0
set ::env(GLB_RT_MAXLAYER) 5

set ::env(ROUTING_CORES) 10

set ::env(FP_PIN_ORDER_CFG) $our_root/pin_order.cfg

set ::env(PDN_CFG) $our_root/pdn.tcl
