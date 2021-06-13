# User config
set ::env(DESIGN_NAME) fpga250

# Change if needed
set ::env(VERILOG_FILES) [concat \
  $::env(OPENLANE_ROOT)/designs/250/new/fpga250.v \
  $::env(OPENLANE_ROOT)/designs/250/new/bb/clb_tile_bb.v \
  $::env(OPENLANE_ROOT)/designs/250/new/bb/wb_config_bb.v \
]

set ::env(EXTRA_LEFS) [ list \
  $::env(OPENLANE_ROOT)/designs/250/gds/clb_tile_new/clb_tile.lef \
  $::env(OPENLANE_ROOT)/designs/250/gds/wb_config/wb_config.lef
]
set ::env(EXTRA_GDS_FILES) [ list \
  $::env(OPENLANE_ROOT)/designs/250/gds/clb_tile_new/clb_tile.gds \
  $::env(OPENLANE_ROOT)/designs/250/gds/wb_config/wb_config.gds \
]

set ::env(MACRO_PLACEMENT_CFG) $::env(OPENLANE_ROOT)/designs/250/asic_config/fpga_new/macro_placement.cfg

set ::env(CLOCK_PORT) "clk"
# Design config
set ::env(CLOCK_PERIOD) 100
set ::env(SYNTH_STRATEGY) "DELAY 1"
#set ::env(SYNTH_STRATEGY) "AREA 2"

set ::env(SYNTH_READ_BLACKBOX_LIB) 1

# This makes sure that the core rings are outside the boundaries
# of your block.
set ::env(MAGIC_ZEROIZE_ORIGIN) 0

# Area Configurations. DON'T TOUCH.
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 2920 3520"

set ::env(RUN_CVC) 0

#set ::env(PL_TARGET_DENSITY) 0.5

set ::unit 2.4
set ::env(FP_IO_VEXTEND) [expr 2*$::unit]
set ::env(FP_IO_HEXTEND) [expr 2*$::unit]
set ::env(FP_IO_VLENGTH) $::unit
set ::env(FP_IO_HLENGTH) $::unit

set ::env(FP_IO_VTHICKNESS_MULT) 4
set ::env(FP_IO_HTHICKNESS_MULT) 4

# Power & Pin Configurations. DON'T TOUCH.
set ::env(FP_PDN_CORE_RING) 1
set ::env(FP_PDN_CORE_RING_VWIDTH) 3
set ::env(FP_PDN_CORE_RING_HWIDTH) $::env(FP_PDN_CORE_RING_VWIDTH)
set ::env(FP_PDN_CORE_RING_VOFFSET) 14
set ::env(FP_PDN_CORE_RING_HOFFSET) $::env(FP_PDN_CORE_RING_VOFFSET)
set ::env(FP_PDN_CORE_RING_VSPACING) 1.7
set ::env(FP_PDN_CORE_RING_HSPACING) $::env(FP_PDN_CORE_RING_VSPACING)

set ::env(FP_PDN_VWIDTH) 3
set ::env(FP_PDN_HWIDTH) 3
set ::env(FP_PDN_VOFFSET) 5
set ::env(FP_PDN_HOFFSET) $::env(FP_PDN_VOFFSET)
set ::env(FP_PDN_VPITCH) 180
set ::env(FP_PDN_HPITCH) $::env(FP_PDN_VPITCH)
set ::env(FP_PDN_VSPACING) [expr 5*$::env(FP_PDN_CORE_RING_VWIDTH)]
set ::env(FP_PDN_HSPACING) [expr 5*$::env(FP_PDN_CORE_RING_HWIDTH)]

#set ::env(VDD_NETS) [list {vccd1} {vccd2} {vdda1} {vdda2}]
#set ::env(GND_NETS) [list {vssd1} {vssd2} {vssa1} {vssa2}]
#set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"

set ::env(GLB_RT_MAXLAYER) 5

set ::env(FP_PDN_CHECK_NODES) 0

# The following is because there are no std cells in the example wrapper project.
#set ::env(SYNTH_TOP_LEVEL) 1
set ::env(PL_RANDOM_GLB_PLACEMENT) 1

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 0
set ::env(PL_RESIZER_BUFFER_INPUT_PORTS) 0
set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

set ::env(DIODE_INSERTION_STRATEGY) 0
set ::env(FILL_INSERTION) 0
set ::env(TAP_DECAP_INSERTION) 0
set ::env(CLOCK_TREE_SYNTH) 0
set ::env(PL_BASIC_PLACEMENT) 0
set ::env(PL_SKIP_INITIAL_PLACEMENT) 0
set ::env(PL_RANDOM_GLB_PLACEMENT) 1

#set ::env(CELL_PAD) 0

set ::env(DESIGN_IS_CORE) 1

set ::env(GLB_RT_OBS) "met1 0 0 $::env(DIE_AREA),\
					             met2 0 0 $::env(DIE_AREA),\
					             met3 0 0 $::env(DIE_AREA),\
					             met4 0 0 $::env(DIE_AREA),\
					             met5 0 0 $::env(DIE_AREA)"

set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0
set ::env(DIODE_INSERTION_STRATEGY) 0

set ::env(MAGIC_WRITE_FULL_LEF) 1

set ::env(FP_PIN_ORDER_CFG) $::env(OPENLANE_ROOT)/designs/250/asic_config/fpga_new/pin_order.cfg
#set ::env(PDN_CFG) $::env(OPENLANE_ROOT)/designs/250/asic_config/fpga_new/pdn.tcl

set ::env(GLB_RT_ALLOW_CONGESTION) 1

set ::env(ROUTING_CORES) 10

#set ::env(GLB_RT_MAX_DIODE_INS_ITERS) "10"

set ::env(ROUTING_OPT_ITERS) "100"

set ::env(USE_ARC_ANTENNA_CHECK) 0
