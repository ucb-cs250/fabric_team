# Begin_DVE_Session_Save_Info
# DVE full session
# Saved on Fri Nov 13 13:17:03 2020
# Designs open: 1
#   V1: vcdplus.vpd
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Source.1: mac_tile_tb
#   Memory.1: 
#   Wave.1: 125 signals
#   Group count = 6
#   Group Group1 signal count = 16
#   Group configuroni signal count = 20
#   Group dataroni signal count = 14
#   Group djaroni signal count = 11
#   Group macaroni signal count = 47
#   Group Group2 signal count = 17
# End_DVE_Session_Save_Info

# DVE version: N-2017.12-SP1-1_Full64
# DVE build date: Apr 20 2018 21:02:57


#<Session mode="Full" path="/home/arya/src/openlane_develop/designs/250/testbench/session.vcdplus.vpd.tcl" type="Debug">

gui_set_loading_session_type Post
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all

# Close all windows
gui_close_window -type Console
gui_close_window -type Wave
gui_close_window -type Source
gui_close_window -type Schematic
gui_close_window -type Data
gui_close_window -type DriverLoad
gui_close_window -type List
gui_close_window -type Memory
gui_close_window -type HSPane
gui_close_window -type DLPane
gui_close_window -type Assertion
gui_close_window -type CovHier
gui_close_window -type CoverageTable
gui_close_window -type CoverageMap
gui_close_window -type CovDetail
gui_close_window -type Local
gui_close_window -type Stack
gui_close_window -type Watch
gui_close_window -type Group
gui_close_window -type Transaction



# Application preferences
gui_set_pref_value -key app_default_font -value {Terminus,8,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE top-level session


# Create and position top-level window: TopLevel.1

if {![gui_exist_window -window TopLevel.1]} {
    set TopLevel.1 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.1 TopLevel.1
}
gui_show_window -window ${TopLevel.1} -show_state normal -rect {{2 1091} {1197 2012}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_hide_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_hide_toolbar -toolbar {Simulator}
gui_hide_toolbar -toolbar {Interactive Rewind}
gui_hide_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
set HSPane.1 [gui_create_window -type HSPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 220]
catch { set Hier.1 [gui_share_window -id ${HSPane.1} -type Hier] }
gui_set_window_pref_key -window ${HSPane.1} -key dock_width -value_type integer -value 220
gui_set_window_pref_key -window ${HSPane.1} -key dock_height -value_type integer -value -1
gui_set_window_pref_key -window ${HSPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${HSPane.1} {{left 0} {top 0} {width 219} {height 645} {dock_state left} {dock_on_new_line true} {child_hier_colhier 140} {child_hier_coltype 100} {child_hier_colpd 0} {child_hier_col1 0} {child_hier_col2 1} {child_hier_col3 -1}}
set DLPane.1 [gui_create_window -type DLPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 458]
catch { set Data.1 [gui_share_window -id ${DLPane.1} -type Data] }
gui_set_window_pref_key -window ${DLPane.1} -key dock_width -value_type integer -value 458
gui_set_window_pref_key -window ${DLPane.1} -key dock_height -value_type integer -value 417
gui_set_window_pref_key -window ${DLPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${DLPane.1} {{left 0} {top 0} {width 457} {height 645} {dock_state left} {dock_on_new_line true} {child_data_colvariable 271} {child_data_colvalue 115} {child_data_coltype 65} {child_data_col1 0} {child_data_col2 1} {child_data_col3 2}}
set Console.1 [gui_create_window -type Console -parent ${TopLevel.1} -dock_state bottom -dock_on_new_line true -dock_extent 170]
gui_set_window_pref_key -window ${Console.1} -key dock_width -value_type integer -value 1915
gui_set_window_pref_key -window ${Console.1} -key dock_height -value_type integer -value 170
gui_set_window_pref_key -window ${Console.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${Console.1} {{left 0} {top 0} {width 1195} {height 169} {dock_state bottom} {dock_on_new_line true}}
#### Start - Readjusting docked view's offset / size
set dockAreaList { top left right bottom }
foreach dockArea $dockAreaList {
  set viewList [gui_ekki_get_window_ids -active_parent -dock_area $dockArea]
  foreach view $viewList {
      if {[lsearch -exact [gui_get_window_pref_keys -window $view] dock_width] != -1} {
        set dockWidth [gui_get_window_pref_value -window $view -key dock_width]
        set dockHeight [gui_get_window_pref_value -window $view -key dock_height]
        set offset [gui_get_window_pref_value -window $view -key dock_offset]
        if { [string equal "top" $dockArea] || [string equal "bottom" $dockArea]} {
          gui_set_window_attributes -window $view -dock_offset $offset -width $dockWidth
        } else {
          gui_set_window_attributes -window $view -dock_offset $offset -height $dockHeight
        }
      }
  }
}
#### End - Readjusting docked view's offset / size
gui_sync_global -id ${TopLevel.1} -option true

# MDI window settings
set Source.1 [gui_create_window -type {Source}  -parent ${TopLevel.1}]
gui_show_window -window ${Source.1} -show_state maximized
gui_update_layout -id ${Source.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false}}
set Memory.1 [gui_create_window -type {Memory}  -parent ${TopLevel.1}]
gui_show_window -window ${Memory.1} -show_state maximized
gui_update_layout -id ${Memory.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false}}

# End MDI window settings


# Create and position top-level window: TopLevel.2

if {![gui_exist_window -window TopLevel.2]} {
    set TopLevel.2 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.2 TopLevel.2
}
gui_show_window -window ${TopLevel.2} -show_state normal -rect {{1202 24} {5037 1064}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_hide_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_hide_toolbar -toolbar {Simulator}
gui_hide_toolbar -toolbar {Interactive Rewind}
gui_set_toolbar_attributes -toolbar {Testbench} -dock_state top
gui_set_toolbar_attributes -toolbar {Testbench} -offset 0
gui_show_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
gui_sync_global -id ${TopLevel.2} -option true

# MDI window settings
set Wave.1 [gui_create_window -type {Wave}  -parent ${TopLevel.2}]
gui_show_window -window ${Wave.1} -show_state maximized
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 510} {child_wave_right 3320} {child_wave_colname 230} {child_wave_colvalue 276} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings

gui_set_env TOPLEVELS::TARGET_FRAME(Source) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Schematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(PathSchematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Wave) none
gui_set_env TOPLEVELS::TARGET_FRAME(List) none
gui_set_env TOPLEVELS::TARGET_FRAME(Memory) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(DriverLoad) none
gui_update_statusbar_target_frame ${TopLevel.1}
gui_update_statusbar_target_frame ${TopLevel.2}

#</WindowLayout>

#<Database>

# DVE Open design session: 

if { ![gui_is_db_opened -db {vcdplus.vpd}] } {
	gui_open_db -design V1 -file vcdplus.vpd -nosource
}
gui_set_precision 10ps
gui_set_time_units 10ps
#</Database>

# DVE Global setting session: 


# Global: Bus

# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups
gui_load_child_values {mac_tile_tb.dut.macaroni}
gui_load_child_values {mac_tile_tb.dut.configuroni}
gui_load_child_values {mac_tile_tb.dut.djaroni}
gui_load_child_values {mac_tile_tb.dut.dataroni}


set _session_group_41 Group1
gui_sg_create "$_session_group_41"
set Group1 "$_session_group_41"

gui_sg_addsignal -group "$_session_group_41" { mac_tile_tb.clk mac_tile_tb.dut.dataroni.c mac_tile_tb.dut.configuroni.internal_config_inter mac_tile_tb.dut.macaroni.cfg mac_tile_tb.dut.djaroni.c mac_tile_tb.cen mac_tile_tb.cset mac_tile_tb.en mac_tile_tb.rst mac_tile_tb.north_reg mac_tile_tb.dut.macaroni.A0 mac_tile_tb.dut.macaroni.B0 mac_tile_tb.dut.macaroni.out0 mac_tile_tb.south mac_tile_tb.east mac_tile_tb.west }
gui_set_radix -radix {binary} -signals {V1:mac_tile_tb.south}
gui_set_radix -radix {unsigned} -signals {V1:mac_tile_tb.south}

set _session_group_42 configuroni
gui_sg_create "$_session_group_42"
set configuroni "$_session_group_42"

gui_sg_addsignal -group "$_session_group_42" { mac_tile_tb.dut.configuroni.comb_config mac_tile_tb.dut.configuroni.internal_config_inter mac_tile_tb.dut.configuroni.MEM_N mac_tile_tb.dut.configuroni.mem_config mac_tile_tb.dut.configuroni.COMB_N mac_tile_tb.dut.configuroni.set_soft mac_tile_tb.dut.configuroni.shift_in_soft mac_tile_tb.dut.configuroni.comb_mem_bridge mac_tile_tb.dut.configuroni.comb_set mac_tile_tb.dut.configuroni.input_mux mac_tile_tb.dut.configuroni.mem_ctrl mac_tile_tb.dut.configuroni.mem_set mac_tile_tb.dut.configuroni.rst mac_tile_tb.dut.configuroni.set_hard mac_tile_tb.dut.configuroni.set_internal mac_tile_tb.dut.configuroni.shift_enable mac_tile_tb.dut.configuroni.shift_in_hard mac_tile_tb.dut.configuroni.shift_in_internal mac_tile_tb.dut.configuroni.shift_out mac_tile_tb.dut.configuroni.clk }
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.configuroni.MEM_N}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.configuroni.MEM_N}
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.configuroni.COMB_N}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.configuroni.COMB_N}

set _session_group_43 dataroni
gui_sg_create "$_session_group_43"
set dataroni "$_session_group_43"

gui_sg_addsignal -group "$_session_group_43" { mac_tile_tb.dut.dataroni.CONF_WIDTH mac_tile_tb.dut.dataroni.DATAIN mac_tile_tb.dut.dataroni.DATAOUT mac_tile_tb.dut.dataroni.WW mac_tile_tb.dut.dataroni.W mac_tile_tb.dut.dataroni.c mac_tile_tb.dut.dataroni.clk mac_tile_tb.dut.dataroni.data_input mac_tile_tb.dut.dataroni.north mac_tile_tb.dut.dataroni.rst mac_tile_tb.dut.dataroni.south mac_tile_tb.dut.dataroni.c_reg mac_tile_tb.dut.dataroni.data_output mac_tile_tb.dut.dataroni.cset }
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.dataroni.CONF_WIDTH}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.dataroni.CONF_WIDTH}
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.dataroni.DATAIN}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.dataroni.DATAIN}
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.dataroni.DATAOUT}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.dataroni.DATAOUT}
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.dataroni.WW}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.dataroni.WW}
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.dataroni.W}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.dataroni.W}

set _session_group_44 djaroni
gui_sg_create "$_session_group_44"
set djaroni "$_session_group_44"

gui_sg_addsignal -group "$_session_group_44" { mac_tile_tb.dut.djaroni.CONF_WIDTH mac_tile_tb.dut.djaroni.W mac_tile_tb.dut.djaroni.c mac_tile_tb.dut.djaroni.c_reg mac_tile_tb.dut.djaroni.clk mac_tile_tb.dut.djaroni.cset mac_tile_tb.dut.djaroni.east mac_tile_tb.dut.djaroni.north mac_tile_tb.dut.djaroni.rst mac_tile_tb.dut.djaroni.south mac_tile_tb.dut.djaroni.west }
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.djaroni.CONF_WIDTH}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.djaroni.CONF_WIDTH}
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.djaroni.W}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.djaroni.W}
gui_set_radix -radix {binary} -signals {V1:mac_tile_tb.dut.djaroni.c_reg}
gui_set_radix -radix {unsigned} -signals {V1:mac_tile_tb.dut.djaroni.c_reg}

set _session_group_45 macaroni
gui_sg_create "$_session_group_45"
set macaroni "$_session_group_45"

gui_sg_addsignal -group "$_session_group_45" { mac_tile_tb.dut.macaroni.A0 mac_tile_tb.dut.macaroni.A0_sign_adjusted mac_tile_tb.dut.macaroni.A1 mac_tile_tb.dut.macaroni.A1_sign_adjusted mac_tile_tb.dut.macaroni.A2 mac_tile_tb.dut.macaroni.A2_sign_adjusted mac_tile_tb.dut.macaroni.A3 mac_tile_tb.dut.macaroni.A3_sign_adjusted mac_tile_tb.dut.macaroni.B0 mac_tile_tb.dut.macaroni.B0_sign_adjusted mac_tile_tb.dut.macaroni.B1 mac_tile_tb.dut.macaroni.B1_sign_adjusted mac_tile_tb.dut.macaroni.B2 mac_tile_tb.dut.macaroni.B2_sign_adjusted mac_tile_tb.dut.macaroni.B3 mac_tile_tb.dut.macaroni.B3_sign_adjusted mac_tile_tb.dut.macaroni.C0_neg mac_tile_tb.dut.macaroni.C1_neg mac_tile_tb.dut.macaroni.C2_neg mac_tile_tb.dut.macaroni.C3_neg mac_tile_tb.dut.macaroni.MAC_ACC_WIDTH mac_tile_tb.dut.macaroni.MAC_CONF_WIDTH mac_tile_tb.dut.macaroni.MAC_INT_WIDTH mac_tile_tb.dut.macaroni.MAC_MIN_WIDTH mac_tile_tb.dut.macaroni.MAC_MULT_WIDTH mac_tile_tb.dut.macaroni.cfg mac_tile_tb.dut.macaroni.clk mac_tile_tb.dut.macaroni.cset mac_tile_tb.dut.macaroni.en mac_tile_tb.dut.macaroni.latched_cfg mac_tile_tb.dut.macaroni.mac_combiner_out0 mac_tile_tb.dut.macaroni.mac_combiner_out0_sign_adjusted mac_tile_tb.dut.macaroni.mac_combiner_out1 mac_tile_tb.dut.macaroni.mac_combiner_out1_sign_adjusted mac_tile_tb.dut.macaroni.mac_combiner_out2 mac_tile_tb.dut.macaroni.mac_combiner_out2_sign_adjusted mac_tile_tb.dut.macaroni.mac_combiner_out3 mac_tile_tb.dut.macaroni.mac_combiner_out3_sign_adjusted mac_tile_tb.dut.macaroni.mac_mul_out0 mac_tile_tb.dut.macaroni.mac_mul_out1 mac_tile_tb.dut.macaroni.mac_mul_out2 mac_tile_tb.dut.macaroni.mac_mul_out3 mac_tile_tb.dut.macaroni.out0 mac_tile_tb.dut.macaroni.out1 mac_tile_tb.dut.macaroni.out2 mac_tile_tb.dut.macaroni.out3 mac_tile_tb.dut.macaroni.rst }
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.macaroni.MAC_ACC_WIDTH}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.macaroni.MAC_ACC_WIDTH}
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.macaroni.MAC_CONF_WIDTH}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.macaroni.MAC_CONF_WIDTH}
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.macaroni.MAC_INT_WIDTH}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.macaroni.MAC_INT_WIDTH}
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.macaroni.MAC_MIN_WIDTH}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.macaroni.MAC_MIN_WIDTH}
gui_set_radix -radix {decimal} -signals {V1:mac_tile_tb.dut.macaroni.MAC_MULT_WIDTH}
gui_set_radix -radix {twosComplement} -signals {V1:mac_tile_tb.dut.macaroni.MAC_MULT_WIDTH}

set _session_group_46 Group2
gui_sg_create "$_session_group_46"
set Group2 "$_session_group_46"

gui_sg_addsignal -group "$_session_group_46" { mac_tile_tb.dut.dataroni.north mac_tile_tb.dut.dataroni.south mac_tile_tb.dut.dataroni.data_input mac_tile_tb.dut.dataroni.data_output mac_tile_tb.dut.dataroni.c_reg mac_tile_tb.dut.macaroni.A0 mac_tile_tb.dut.macaroni.B0 mac_tile_tb.dut.macaroni.A1 mac_tile_tb.dut.macaroni.B1 mac_tile_tb.dut.macaroni.A2 mac_tile_tb.dut.macaroni.B2 mac_tile_tb.dut.macaroni.A3 mac_tile_tb.dut.macaroni.B3 mac_tile_tb.dut.macaroni.out0 mac_tile_tb.dut.macaroni.out1 mac_tile_tb.dut.macaroni.out2 mac_tile_tb.dut.macaroni.out3 }

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 11816557



# Save global setting...

# Wave/List view global setting
gui_cov_show_value -switch false

# Close all empty TopLevel windows
foreach __top [gui_ekki_get_window_ids -type TopLevel] {
    if { [llength [gui_ekki_get_window_ids -parent $__top]] == 0} {
        gui_close_window -window $__top
    }
}
gui_set_loading_session_type noSession
# DVE View/pane content session: 


# Hier 'Hier.1'
gui_show_window -window ${Hier.1}
gui_list_set_filter -id ${Hier.1} -list { {Package 1} {All 0} {Process 1} {VirtPowSwitch 0} {UnnamedProcess 1} {UDP 0} {Function 1} {Block 1} {SrsnAndSpaCell 0} {OVA Unit 1} {LeafScCell 1} {LeafVlgCell 1} {Interface 1} {LeafVhdCell 1} {$unit 1} {NamedBlock 1} {Task 1} {VlgPackage 1} {ClassDef 1} {VirtIsoCell 0} }
gui_list_set_filter -id ${Hier.1} -text {*}
gui_hier_list_init -id ${Hier.1}
gui_change_design -id ${Hier.1} -design V1
catch {gui_list_expand -id ${Hier.1} mac_tile_tb}
catch {gui_list_expand -id ${Hier.1} mac_tile_tb.dut}
catch {gui_list_select -id ${Hier.1} {mac_tile_tb.dut.dataroni}}
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {mac_tile_tb.dut.dataroni}
gui_show_window -window ${Data.1}
catch { gui_list_select -id ${Data.1} {mac_tile_tb.dut.dataroni.data_input }}
gui_view_scroll -id ${Data.1} -vertical -set 0
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
gui_open_source -id ${Source.1}  -replace -active mac_tile_tb mac_tile_tb.v
gui_view_scroll -id ${Source.1} -vertical -set 360
gui_src_set_reusable -id ${Source.1}

# View 'Memory.1'
gui_show_memory -window ${Memory.1} -memory {mac_tile_tb.config_stream[5905:0]}
gui_set_memory_properties -window ${Memory.1} -columns 1 -address_factor 1 -address_offset 0 -start_address 0 -end_address -1 -address_radix 10
gui_view_scroll -id ${Memory.1} -vertical -set 0
gui_view_scroll -id ${Memory.1} -horizontal -set 0

# View 'Wave.1'
gui_wv_sync -id ${Wave.1} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_set_ref -id ${Wave.1}  C1
gui_wv_zoom_timerange -id ${Wave.1} 11812785 11818480
gui_list_add_group -id ${Wave.1} -after {New Group} {Group1}
gui_list_add_group -id ${Wave.1} -after {New Group} {configuroni}
gui_list_add_group -id ${Wave.1} -after {New Group} {dataroni}
gui_list_add_group -id ${Wave.1} -after {New Group} {djaroni}
gui_list_add_group -id ${Wave.1} -after {New Group} {macaroni}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group2}
gui_list_collapse -id ${Wave.1} configuroni
gui_list_collapse -id ${Wave.1} dataroni
gui_list_collapse -id ${Wave.1} djaroni
gui_list_collapse -id ${Wave.1} macaroni
gui_list_select -id ${Wave.1} {mac_tile_tb.dut.dataroni.north }
gui_seek_criteria -id ${Wave.1} {Any Edge}



gui_set_env TOGGLE::DEFAULT_WAVE_WINDOW ${Wave.1}
gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.1} -text {*}
gui_list_set_insertion_bar  -id ${Wave.1} -group Group2  -item {mac_tile_tb.dut.dataroni.c_reg[4607:0]} -position below

gui_marker_move -id ${Wave.1} {C1} 11816557
gui_view_scroll -id ${Wave.1} -vertical -set 156
gui_show_grid -id ${Wave.1} -enable false
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.1}]} {
	gui_set_active_window -window ${TopLevel.1}
	gui_set_active_window -window ${Memory.1}
	gui_set_active_window -window ${DLPane.1}
}
if {[gui_exist_window -window ${TopLevel.2}]} {
	gui_set_active_window -window ${TopLevel.2}
	gui_set_active_window -window ${Wave.1}
}
#</Session>

