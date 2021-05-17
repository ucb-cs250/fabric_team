# TODO(aryap): license

package require openlane;

proc forbid_area_placement {args} {
    set ::env(SAVE_DEF) $::env(TMP_DIR)/placement/$::env(DESIGN_NAME).forbid.def
    try_catch python3 $::env(DESIGN_DIR)/scripts/place_forbid_area.py -l $::env(MERGED_LEF) -id $::env(CURRENT_DEF) -o $::env(SAVE_DEF) -m $::env(MACRO_PLACEMENT_CFG) |& tee $::env(TERMINAL_OUTPUT) $::env(LOG_DIR)/forbid.log
    set_def $::env(SAVE_DEF)
}

