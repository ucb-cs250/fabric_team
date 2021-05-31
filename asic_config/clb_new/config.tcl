# User config
set ::env(DESIGN_NAME) clb

# Change if needed
#set ::env(VERILOG_FILES) [glob $::env(OPENLANE_ROOT)/designs/250/new/*.v]
set ::env(VERILOG_FILES) [concat \
  $::env(OPENLANE_ROOT)/designs/250/new/clb.v \
  $::env(OPENLANE_ROOT)/designs/250/new/lut4.v \
  $::env(OPENLANE_ROOT)/designs/250/new/luts44.v \
  $::env(OPENLANE_ROOT)/designs/250/new/config_block.v \
  $::env(OPENLANE_ROOT)/designs/250/new/latch.v \
  $::env(OPENLANE_ROOT)/designs/250/new/dff.v \
  $::env(OPENLANE_ROOT)/designs/250/new/carrychain.v \
  $::env(OPENLANE_ROOT)/designs/250/new/mux2.v \
  $::env(OPENLANE_ROOT)/designs/250/new/mux4.v \
  $::env(OPENLANE_ROOT)/designs/250/new/registers.v \
]

set ::env(CLOCK_PORT) "clk"
# Design config
set ::env(CLOCK_PERIOD) 30
set ::env(SYNTH_STRATEGY) "DELAY 1"

set ::env(FP_CORE_UTIL) 80
set ::env(PL_TARGET_DENSITY) 0.90

set ::env(CELL_PAD) 0
set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0


