# User config
#set ::env(DESIGN_NAME) clb
#set ::env(DESIGN_NAME) config_block
#set ::env(DESIGN_NAME) cb
#set ::env(DESIGN_NAME) sb
set ::env(DESIGN_NAME) clb_tile
#set ::env(DESIGN_NAME) MUX4_CFG

# Change if needed
#set ::env(VERILOG_FILES) [glob $::env(OPENLANE_ROOT)/designs/250/new/*.v]
set ::env(VERILOG_FILES) [concat \
  $::env(OPENLANE_ROOT)/designs/250/new/clb_tile.v \
  $::env(OPENLANE_ROOT)/designs/250/new/clb.v \
  $::env(OPENLANE_ROOT)/designs/250/new/lut4.v \
  $::env(OPENLANE_ROOT)/designs/250/new/luts44.v \
  $::env(OPENLANE_ROOT)/designs/250/new/config_block.v \
  $::env(OPENLANE_ROOT)/designs/250/new/latch.v \
  $::env(OPENLANE_ROOT)/designs/250/new/dff.v \
  $::env(OPENLANE_ROOT)/designs/250/new/carrychain.v \
  $::env(OPENLANE_ROOT)/designs/250/new/mux2.v \
  $::env(OPENLANE_ROOT)/designs/250/new/mux4.v \
  $::env(OPENLANE_ROOT)/designs/250/new/mux2_cfg.v \
  $::env(OPENLANE_ROOT)/designs/250/new/mux4_cfg.v \
  $::env(OPENLANE_ROOT)/designs/250/new/registers.v \
  $::env(OPENLANE_ROOT)/designs/250/new/cb.v \
  $::env(OPENLANE_ROOT)/designs/250/new/muxn.v \
  $::env(OPENLANE_ROOT)/designs/250/new/sb.v \
]

#set ::env(EXTRA_LEFS) [ concat \
#  $::env(OPENLANE_ROOT)/designs/250/new/mux4_cfg.lef \
#]
#
#set ::env(EXTRA_GDS_FILES) [ concat \
#  $::env(OPENLANE_ROOT)/designs/250/new/mux4_cfg.gds \
#]

set ::env(MACRO_PLACEMENT_CFG) $::env(OPENLANE_ROOT)/designs/250/asic_config/clb_new/macro_placement.cfg

set ::env(CLOCK_PORT) "clk"
# Design config
set ::env(CLOCK_PERIOD) 100
set ::env(SYNTH_STRATEGY) "DELAY 1"
#set ::env(SYNTH_STRATEGY) "AREA 2"

set ::env(SYNTH_READ_BLACKBOX_LIB) 1

set ::env(FP_CORE_UTIL) 80
set ::env(PL_TARGET_DENSITY) 0.85

set ::env(CELL_PAD) 0
set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0
set ::env(CLOCK_TREE_SYNTH) 1

set ::env(FP_PIN_ORDER_CFG) $::env(OPENLANE_ROOT)/designs/250/asic_config/clb_new/pin_order.cfg
set ::env(PDN_CFG) $::env(OPENLANE_ROOT)/designs/250/asic_config/clb_new/pdn.tcl

set ::env(GLB_RT_ALLOW_CONGESTION) 1

set ::env(ROUTING_CORES) 10

set ::env(GLB_RT_MAX_DIODE_INS_ITERS) "10"

set ::env(USE_ARC_ANTENNA_CHECK) 0
