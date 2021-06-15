set ::power_nets $::env(VDD_PIN)
set ::ground_nets $::env(GND_PIN)

set ::macro_blockage_layer_list "li1 met1 met2 met3 met4 met5"

pdngen::specify_grid stdcell {
    name grid
    rails {
      met1 {width $::env(FP_PDN_RAIL_WIDTH) pitch $::env(PLACE_SITE_HEIGHT) offset $::env(FP_PDN_RAIL_OFFSET)}
    }
    straps {
      met4 {width $::env(FP_PDN_VWIDTH) pitch $::env(FP_PDN_VPITCH) offset $::env(FP_PDN_VOFFSET)}
    }
    connect {{met1 met4}}
}

## Specify macro-level info for mac block.
#pdngen::specify_grid macro {
#  #instance my_mac
#  macro baked_connection_block_north
#  power_pins VPWR
#  blockages "li1 met1 met2 met3 met4"
#  straps {
#  }
#  #connect {{met5 met4}}
#  connect {{met4_PIN_ver met5}}
#}
#
#pdngen::specify_grid macro {
#  macro baked_connection_block_east
#  power_pins VPWR
#  ground_pins VGND
#  blockages "li1 met1 met2 met3 met4"
#  straps {
#  }
#  connect {{met4_PIN_ver met5}}
#}
#
#pdngen::specify_grid macro {
#  macro baked_connection_block_north
#  power_pins VPWR
#  ground_pins VGND
#  blockages "li1 met1 met2 met3 met4"
#  straps {
#  }
#  connect {{met4_PIN_ver met5}}
#}
#
#pdngen::specify_grid macro {
#  macro baked_clb_switch_box
#  power_pins VPWR
#  ground_pins VGND
#  blockages "li1 met1 met2 met3 met4"
#  straps {
#  }
#  connect {{met4_PIN_ver met5}}
#}
#
#pdngen::specify_grid macro {
#  macro baked_slicel
#  power_pins VPWR
#  ground_pins VGND
#  blockages "li1 met1 met2 met3 met4"
#  straps {
#  }
#  connect {{met4_PIN_ver met5}}
#}

set ::halo 0

# Metal layer for rails on every row
set ::rails_mlayer "met1" ;

# POWER or GROUND #Std. cell rails starting with power or ground rails at the bottom of the core area
set ::rails_start_with "POWER" ;

# POWER or GROUND #Upper metal stripes starting with power or ground rails at the left/bottom of the core area
set ::stripes_start_with "POWER" ;
