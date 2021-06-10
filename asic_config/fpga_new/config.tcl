# User config
set ::env(DESIGN_NAME) fpga250

# Change if needed
set ::env(VERILOG_FILES) [concat \
  $::env(OPENLANE_ROOT)/designs/250/new/fpga250.v \
  $::env(OPENLANE_ROOT)/designs/250/new/clb_tile.v \
]

set ::env(EXTRA_LEFS) [ list $::env(OPENLANE_ROOT)/designs/250/asic_config/clb_new/clb_tile.lef ]
set ::env(EXTRA_GDS_FILES) [ list $::env(OPENLANE_ROOT)/designs/250/asic_config/clb_new/clb_tile.gds ]

set ::env(MACRO_PLACEMENT_CFG) $::env(OPENLANE_ROOT)/designs/250/asic_config/fpga_new/macro_placement.cfg

set ::env(CLOCK_PORT) "clk"
# Design config
set ::env(CLOCK_PERIOD) 100
set ::env(SYNTH_STRATEGY) "DELAY 1"
#set ::env(SYNTH_STRATEGY) "AREA 2"

set ::env(SYNTH_READ_BLACKBOX_LIB) 1

#set ::env(FP_CORE_UTIL) 80
#set ::env(PL_TARGET_DENSITY) 0.85

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 2920 3520"

set ::env(FP_PDN_CHECK_NODES) 0

#set ::env(PL_TARGET_DENSITY) 0.5

set ::env(PL_BASIC_PLACEMENT) 0
set ::env(PL_SKIP_INITIAL_PLACEMENT) 0
set ::env(PL_RANDOM_GLB_PLACEMENT) 1

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_BUFFER_INPUT_PORTS) 0
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

set ::env(DIODE_INSERTION_STRATEGY) 0
set ::env(FILL_INSERTION) 0
set ::env(TAP_DECAP_INSERTION) 0
set ::env(CLOCK_TREE_SYNTH) 0

#set ::env(CELL_PAD) 0
set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 1

set ::env(DESIGN_IS_CORE) 1

set ::env(FP_PIN_ORDER_CFG) $::env(OPENLANE_ROOT)/designs/250/asic_config/fpga_new/pin_order.cfg
set ::env(PDN_CFG) $::env(OPENLANE_ROOT)/designs/250/asic_config/fpga_new/pdn.tcl

#set ::env(GLB_RT_ALLOW_CONGESTION) 1

set ::env(ROUTING_CORES) 10

set ::env(GLB_RT_MAX_DIODE_INS_ITERS) "10"

set ::env(USE_ARC_ANTENNA_CHECK) 0
