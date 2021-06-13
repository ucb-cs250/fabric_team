# User config
set ::env(DESIGN_NAME) wb_config

# Change if needed
#set ::env(VERILOG_FILES) [glob $::env(OPENLANE_ROOT)/designs/250/new/*.v]
set ::env(VERILOG_FILES) [concat \
  $::env(OPENLANE_ROOT)/designs/250/new/registers.v \
  $::env(OPENLANE_ROOT)/designs/250/new/wb_config.v \
]

set ::env(MACRO_PLACEMENT_CFG) $::env(OPENLANE_ROOT)/designs/250/asic_config/wb_config/macro_placement.cfg

set ::env(CLOCK_PORT) "wb_clk_i"
# Design config
set ::env(CLOCK_PERIOD) 10
set ::env(SYNTH_STRATEGY) "DELAY 1"
#set ::env(SYNTH_STRATEGY) "AREA 2"

#set ::env(SYNTH_READ_BLACKBOX_LIB) 1

#set ::env(FP_SIZING) absolute
#set ::env(DIE_AREA) "0 0 200 200"
#set ::env(PL_BASIC_PLACEMENT) 1

set ::env(FP_CORE_UTIL) 75
set ::env(PL_TARGET_DENSITY) 0.85

set ::env(CELL_PAD) 0
set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 1
set ::env(CLOCK_TREE_SYNTH) 1

set ::env(FP_PIN_ORDER_CFG) $::env(OPENLANE_ROOT)/designs/250/asic_config/wb_config/pin_order.cfg
set ::env(PDN_CFG) $::env(OPENLANE_ROOT)/designs/250/asic_config/wb_config/pdn.tcl

set ::env(DESIGN_IS_CORE) 0

#set ::env(VDD_NETS) [list {vccd1} {vccd2} {vdda1} {vdda2}]
#set ::env(GND_NETS) [list {vssd1} {vssd2} {vssa1} {vssa2}]

#set ::env(GLB_RT_ALLOW_CONGESTION) 1

#set ::env(ROUTING_CORES) 10

#set ::env(GLB_RT_MAX_DIODE_INS_ITERS) "10"

#set ::env(RUN_CVC) 0

set ::env(USE_ARC_ANTENNA_CHECK) 0
