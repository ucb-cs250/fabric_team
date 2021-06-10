set ::power_nets $::env(VDD_PIN)
set ::ground_nets $::env(GND_PIN)

set ::macro_blockage_layer_list "li1 met1 met2 met3 met4 met5"

    #core_ring {
    #  met4 {width 3 spacing 1.6 core_offset 5}
    #  met5 {width 3 spacing 1.6 core_offset 5}
    #}
pdngen::specify_grid stdcell {
    name grid
    rails {
      met1 {width $::env(FP_PDN_RAIL_WIDTH) pitch $::env(PLACE_SITE_HEIGHT) offset $::env(FP_PDN_RAIL_OFFSET)}
    }
    straps {
      met4 {width $::env(FP_PDN_VWIDTH) pitch $::env(FP_PDN_VPITCH) offset $::env(FP_PDN_VOFFSET)}
      met5 {width $::env(FP_PDN_HWIDTH) pitch $::env(FP_PDN_HPITCH) offset $::env(FP_PDN_HOFFSET)}
    }
    connect {{met1 met4} {met4 met5}}
}

# Specify macro-level info for mac block.
pdngen::specify_grid macro {
  macro clb_tile
  power_pins VPWR
  ground_pins VGND
  blockages "li1 met1 met2 met3 met4"
  straps {
  }
  connect {{met4_PIN_ver met5}}
}

set ::halo 0

# Metal layer for rails on every row
set ::rails_mlayer "met1" ;

# POWER or GROUND #Std. cell rails starting with power or ground rails at the bottom of the core area
set ::rails_start_with "POWER" ;

# POWER or GROUND #Upper metal stripes starting with power or ground rails at the left/bottom of the core area
set ::stripes_start_with "POWER" ;
