#!/usr/bin/tclsh
package require openlane;

#proc run_placement_pyfive {args} {
#	puts_info "Running PyFive Placement..."
#
#	set ::env(CURRENT_STAGE) placement
#
#    if { [info exists ::env(PL_TARGET_DENSITY_CELLS)] } {
#        set old_pl_target_density $::env(PL_TARGET_DENSITY)
#        set ::env(PL_TARGET_DENSITY) $::env(PL_TARGET_DENSITY_CELLS)
#    }
#
#	if { $::env(PL_RANDOM_GLB_PLACEMENT) } {
#		# useful for very tiny designs
#		random_global_placement
#	} else {
#		global_placement_or
#	}
#
#	if { [info exists ::env(PL_TARGET_DENSITY_CELLS)] } {
#		set ::env(PL_TARGET_DENSITY) $old_pl_target_density
#	}
#
#	if { $::env(PL_RESIZER_OVERBUFFER) == 1} {
#		repair_wire_length
#	}
#	if { $::env(PL_OPENPHYSYN_OPTIMIZATIONS) == 1} {
#		run_openPhySyn
#	}
#
#	forbid_area_placement
#
#    detailed_placement_or
#}


proc run_flow {args} {
	set script_dir [file dirname [file normalize [info script]]]
	set options {
		{-save_path optional}
		{-tag optional}
	}
	set flags {-save}
	parse_key_args "run_flow" args arg_values $options flags_map $flags -no_consume

	prep -design $script_dir {*}$args

  source $script_dir/scripts/aux.tcl

  run_synthesis
  run_floorplan
  #random_global_placement ;# instead of
  global_placement_or
  forbid_area_placement
  #detailed_placement ;# in addition to:
  detailed_placement_or
  run_cts

	gen_pdn
	run_routing
  # - expands into:
  #use_original_lefs
  #global_routing
  #ins_fill_cells

	#if { $::env(DIODE_INSERTION_STRATEGY) == 2 } {
	#	run_antenna_check
	#	heal_antenna_violators; # modifies the routed DEF
	#}

	#if { $::env(LVS_INSERT_POWER_PINS) } {
	#	write_powered_verilog
	#	set_netlist $::env(lvs_result_file_tag).powered.v
	#}

	#run_magic

	#run_magic_spice_export

	#if {  [info exists flags_map(-save) ] } {
	#	if { [info exists arg_values(-save_path)] } {
	#		save_views 	-lef_path $::env(magic_result_file_tag).lef \
	#			-def_path $::env(tritonRoute_result_file_tag).def \
	#			-gds_path $::env(magic_result_file_tag).gds \
	#			-mag_path $::env(magic_result_file_tag).mag \
	#			-spice_path $::env(magic_result_file_tag).spice \
	#			-verilog_path $::env(CURRENT_NETLIST) \
	#			-save_path $arg_values(-save_path) \
	#			-tag $::env(RUN_TAG)
	#	} else  {
	#		save_views 	-lef_path $::env(magic_result_file_tag).lef \
	#			-def_path $::env(tritonRoute_result_file_tag).def \
	#			-mag_path $::env(magic_result_file_tag).mag \
	#			-gds_path $::env(magic_result_file_tag).gds \
	#			-spice_path $::env(magic_result_file_tag).spice \
	#			-verilog_path $::env(CURRENT_NETLIST) \
	#			-tag $::env(RUN_TAG)
	#	}
	#}

	## Physical verification

	#run_magic_drc

	#run_lvs; # requires run_magic_spice_export

	#run_antenna_check

	#generate_final_summary_report

	#puts_success "Flow Completed Without Fatal Errors."
}

run_flow {*}$argv
