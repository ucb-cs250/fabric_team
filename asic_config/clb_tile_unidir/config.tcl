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
set ::env(DESIGN_NAME) clb_tile_unidir
set ::env(DESIGN_IS_CORE) 0
set ::env(PDK_VARIANT) sky130_fd_sc_hd

set design_root $::env(OPENLANE_ROOT)/designs
set src_root $design_root/250
set our_root $src_root/asic_config/clb_tile_unidir

set fabric_src $src_root/src
set config_src $src_root/config_team/src/behavioral
set ix_unidir_src $src_root/ix_yukio/unidir_src
set ix_util $src_root/ix_yukio/util
set clb_src $src_root/clb_team/src/behavioral

set baked_bb_src $fabric_src/blackbox
set baked_src $fabric_src/baked

set nate_src $src_root/ix_nate

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

# Additional mapping.
set ::env(TRISTATE_BUFFER_MAP) $src_root/src/tbuf_map.v
set ::env(SYNTH_MUX_MAP) $src_root/src/mux_map.v

# Requires open_pdks at tag:mpw-one-a
set ::env(SYNTH_LATCH_MAP) $::env(PDK_ROOT)/open_pdks/sky130/openlane/$::env(PDK_VARIANT)/latch_map.v

# Verilog files for top level RTL connections. Do not include black boxes!
set ::env(VERILOG_FILES) [concat \
  $fabric_src/clb_tile_unidir.v \
  $baked_src/baked_connection_block_north_unidir.v \
  $baked_src/baked_connection_block_east_unidir.v \
  $baked_src/baked_connection_block_unidir.v \
  $baked_src/baked_clb_switch_box_unidir.v \
  $baked_src/baked_slicel.v \
  $clb_src/slicel.v \
  $clb_src/lut_sXX_softcode.v \
  $clb_src/carry_chain.v \
  $clb_src/mux_f_slice.v \
  $clb_src/lut.v \
  $clb_src/block_config_latches.v \
  $ix_unidir_src/connection_block.v \
  $ix_unidir_src/clb_switch_box.v \
  $ix_unidir_src/switch_box_element_two.v \
  $ix_unidir_src/switch_box_element_one.v \
  $ix_unidir_src/universal_switch_box.v \
  [glob $ix_util/*.v] \
  [glob $config_src/*.v] \
]

#set ::env(EXTRA_LEFS) [list $slicel_lef $nate_lef ]; #$cb_n_lef $cb_e_lef $sb_lef]
#set ::env(EXTRA_GDS_FILES) [list $slicel_gds $nate_gds ]; # $cb_n_gds $cb_e_gds $sb_gds]
#set ::env(EXTRA_LEFS) [list $nate_lef ]; #$cb_n_lef $cb_e_lef $sb_lef]
#set ::env(EXTRA_GDS_FILES) [list $nate_gds ]; # $cb_n_gds $cb_e_gds $sb_gds]

set filename $::env(OPENLANE_ROOT)/designs/250/$::env(PDK)_$::env(PDK_VARIANT)_config.tcl
if { [file exists $filename] == 1} {
  source $filename
}

set ::env(MACRO_PLACEMENT_CFG) $our_root/macro_placement.cfg

set ::env(CLOCK_PERIOD) 3
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_TREE_SYNTH) 3
set ::env(SYNTH_MAX_FANOUT) 8
set ::env(SYNTH_STRATEGY) 3
#set ::env(SYNTH_BUFFERING) 0
#set ::env(SYNTH_SIZING) 1

#set ::env(CLOCK_BUFFER_FANOUT) 8
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
#set ::env(FILL_INSERTION) 0
set ::env(CELL_PAD) 0
#set ::env(DIODE_INSERTION_STRATEGY) 2

set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0

#set ::env(FAKEDIODE_CELL) "sky130_fd_sc_hd__fakediode_2"

#set ::env(FP_SIZING) "absolute"
#set ::env(DIE_AREA) [list 0.0 0.0 580.0 640.0]
# Halo around the Macros
#set ::env(FP_HORIZONTAL_HALO) 23
#set ::env(FP_VERTICAL_HALO) 23
set ::env(FP_CORE_UTIL) 80
#set ::env(FP_PDN_VOFFSET) 0
#set ::env(FP_PDN_VPITCH) 30

#set ::env(PL_TARGET_DENSITY) 0.34
set ::env(PL_TARGET_DENSITY) 0.85

# These were set to attempt to skip global placement, which we don't seem to be
# able to satisfy with only 4 cells to move around.
# set ::env(PL_BASIC_PLACEMENT) 0
#set ::env(PL_SKIP_INITIAL_PLACEMENT) 1
#set ::env(PL_RANDOM_GLB_PLACEMENT) 1
#
#set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0

set ::env(GLB_RT_ALLOW_CONGESTION) 1

#set ::env(GLB_RT_ADJUSTMENT) 0
#set ::env(GLB_RT_MAXLAYER) 2    ;# Don't route on li1
set ::env(GLB_RT_MAXLAYER) 4    ;# Don't route on met4 or met5
#set ::env(GLB_RT_OBS) "li1 0.00 22.68 1748.00 486.24, li1 0.00 851.08 1748.00 486.24, met5 0.0 0.0 1748.0 1360.0"

set ::env(GLB_RT_ADJUSTMENT) "0.3"

set ::env(ROUTING_CORES) 10

set ::env(FP_PIN_ORDER_CFG) $our_root/pin_order.cfg

set ::env(PDN_CFG) $our_root/pdn.tcl

set ::env(GLB_RT_MAX_DIODE_INS_ITERS) "10"

set ::env(USE_ARC_ANTENNA_CHECK) 0
