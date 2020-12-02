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
set ::env(DESIGN_NAME) fpga
set ::env(PDK_VARIANT) sky130_fd_sc_hd

set design_root $::env(OPENLANE_ROOT)/designs
set src_root $design_root/250
set our_root $src_root/asic_config/fpga

set fabric_src $src_root/src
set blackbox_src $fabric_src/blackbox

# sram_tile

# mac_tile
set mac_runs $design_root/250/asic_config/mac_tile
set mac_run {baked_interactive}
set mac_lef $mac_runs/runs/$mac_run/results/magic/mac_tile.lef
set mac_gds $mac_runs/runs/$mac_run/results/magic/mac_tile.gds

# clb_tile
set clb_runs $design_root/250/asic_config/clb_tile
set clb_run {works_sometimes}
set clb_lef $clb_runs/runs/$clb_run/results/magic/clb_tile.lef
set clb_gds $clb_runs/runs/$clb_run/results/magic/clb_tile.gds

# Verilog files for top level RTL connections. Do not include black boxes!
set ::env(VERILOG_FILES) [concat \
  $fabric_src/fpga.v \
  $blackbox_src/clb_tile.v \
  $blackbox_src/mac_tile.v \
]

set ::env(TRISTATE_BUFFER_MAP) $src_root/src/tbuf_map.v

set ::env(EXTRA_LEFS) [list $mac_lef $clb_lef]
set ::env(EXTRA_GDS_FILES) [list $mac_gds $clb_gds]

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
#set ::env(FP_SIZING) absolute
#set ::env(DIE_AREA) "0 0 2100 2200"
#set ::env(SYNTH_STRATEGY) 1
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
#set ::set(SYNTH_FLAT_TOP) 1

set ::env(FP_CORE_UTIL) 50
set ::env(FP_PDN_VOFFSET) 0
set ::env(FP_PDN_VPITCH) 30

# This was the finest I could tune the parameter, but it still failed.
set ::env(PL_TARGET_DENSITY) 0.55

#set ::env(PL_BASIC_PLACEMENT) 0
#set ::env(PL_SKIP_INITIAL_PLACEMENT) 1
#set ::env(PL_RANDOM_GLB_PLACEMENT) 0

#set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0

#set ::env(GLB_RT_ADJUSTMENT) 0

set ::env(ROUTING_CORES) 10

set ::env(FP_PIN_ORDER_CFG) $our_root/pin_order.cfg

set ::env(PDN_CFG) $our_root/pdn.tcl
