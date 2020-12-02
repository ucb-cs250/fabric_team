# 
# OPENLANE CONFIGURATION FILE
#

# User config
set ::env(PDK_VARIANT) sky130_fd_sc_hd

set design_root $::env(OPENLANE_ROOT)/designs
set src_root $design_root/250
set baked_src $src_root/src/baked

# Load configuration for base baked_connection_block.
source $src_root/asic_config/baked_connection_block/config.tcl

set ::env(DESIGN_NAME) baked_connection_block_east

# Verilog files for top level RTL connections. Do not include black boxes!
set ::env(VERILOG_FILES) [concat \
  $baked_src/baked_connection_block_east.v \
  $::env(VERILOG_FILES) \
]
puts $::env(VERILOG_FILES)

# Floorplan config
set ::env(FP_CORE_UTIL) 40
# Placement config
set ::env(PL_TARGET_DENSITY) [ expr ($::env(FP_CORE_UTIL)+5) / 100.0 ]

# Pin config
set ::env(PDN_CFG) $::env(DESIGN_DIR)/pdn.tcl
set ::env(FP_PIN_ORDER_CFG) $::env(DESIGN_DIR)/pin_order.cfg
