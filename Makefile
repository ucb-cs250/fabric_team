
### Examples
# make sim test=testbench/clb_with_config_test.v
# make sim test=ix_yukio/testbench/clb_switch_box_tb.v

#VCS = vcs -full64
VCS = vcs

CLB_PATH      = clb_team
CFG_PATH      = config_team
MAC_PATH      = mac_team
SRAM_PATH     = sram_team
IX_YUKIO_PATH = ix_yukio
IX_NATE_PATH  = ix_nate

INCS = src+$(MAC_PATH)/src

COMB_OUTPUT_FILE=comb_output.txt
SYNC_OUTPUT_FILE=sync_output.txt
BITSTREAM_FILE=bitstream.txt
UNITTESTS=scripts/new_config/unittests.py
TEST_SCRIPT=scripts/new_config/main.py
MK_GEN_SCRIPT=scripts/asic_flow/Cell_Extractor.py
SYNTHESIS_REPORT=cell_netlists/clb_tile/yosys_3.stat.rpt

SRCS = $(CLB_PATH)/src/behavioral/lut.v \
       $(CLB_PATH)/src/behavioral/lut_sXX_softcode.v \
       $(CLB_PATH)/src/behavioral/carry_chain.v \
       $(CLB_PATH)/src/behavioral/block_config_latches.v \
       $(CLB_PATH)/src/behavioral/mux_f_slice.v \
       $(CLB_PATH)/src/behavioral/slicel.v \
       $(CFG_PATH)/src/behavioral/config_sram_data.v \
       $(CFG_PATH)/src/behavioral/config_latch.v \
       $(CFG_PATH)/src/behavioral/config_tile.v \
       $(CFG_PATH)/src/behavioral/shift_chain.v \
       $(CFG_PATH)/src/behavioral/wishbone_configuratorinator.v \
       $(IX_YUKIO_PATH)/src/clb_switch_box.v \
       $(IX_YUKIO_PATH)/src/universal_switch_box.v \
       $(IX_YUKIO_PATH)/src/switch_box_element_one.v \
       $(IX_YUKIO_PATH)/src/switch_box_element_two.v \
       $(IX_YUKIO_PATH)/src/transmission_gate.v \
       $(IX_YUKIO_PATH)/src/transmission_gate_oneway.v \
       $(IX_YUKIO_PATH)/src/connection_block.v \
       $(IX_YUKIO_PATH)/src/transmission_gate_cell.v \
       $(CFG_PATH)/src/wrapped/wishbone_configuratorinator_00.v \
       $(CFG_PATH)/src/wrapped/wishbone_configuratorinator_10.v \
       src/baked/baked_slicel.v \
       src/baked/baked_clb_switch_box.v \
       src/baked/baked_connection_block.v \
       src/baked/baked_connection_block_east.v \
       src/baked/baked_connection_block_north.v \
       src/clb_tile.v \
       src/fpga.v \

GATE_SRCS = cell_netlists/clb_tile/clb_tile.synthesis.v \
            $(IX_YUKIO_PATH)/src/transmission_gate_cell.v \

OPTS = -notice \
       -line \
       +lint=all,noVCDE,noONGS,noUI \
       +warn=noTMR \
       +v2k \
       +vcs+lic+wait \
       +rad \
       -quiet \
       -sverilog \
       +error+100 \
       -timescale=1ns/1ps \
       -v2005 \
       +vcs+loopdetect \
       +vcs+vcdpluson

test = path_to_a_test_bench_file
testname = $(basename $(notdir $(test)))
SIMV = ./$(testname).simv
GATE_SIMV = ./$(testname)_gate.simv

SKY130_CELLS_D_MK = sky130_cells_dep.mk
-include $(SKY130_CELLS_D_MK)

$(SIMV): $(SRCS) $(test)
	$(VCS) $(OPTS) +incdir+$(INCS) $^ -o $@

$(GATE_SIMV): $(GATE_SRCS) $(SKY130_CELLS) $(test)
	$(VCS) $(OPTS) +incdir+$(INCS)+$(SKY130_INCS) +define+FUNCTIONAL+UNIT_DELAY="#5.0" $^ -o $@

$(BITSTREAM_FILE): $(UNITTESTS)
	python3 $(UNITTESTS)

sim-rtl: $(SIMV) $(BITSTREAM_FILE)
	$(SIMV) -q +ntb_random_seed_automatic +load_config=$(BITSTREAM_FILE) +load_sync_output=$(SYNC_OUTPUT_FILE) +load_comb_output=$(COMB_OUTPUT_FILE)

$(SKY130_CELLS_D_MK): $(MK_GEN_SCRIPT) $(SYNTHESIS_REPORT)
	python3 $(MK_GEN_SCRIPT) $(SYNTHESIS_REPORT)

sim-gl: $(SKY130_CELLS_D_MK) $(GATE_SIMV) $(BITSTREAM_FILE)
	$(GATE_SIMV) -q +ntb_random_seed_automatic +load_config=$(BITSTREAM_FILE) +load_sync_output=$(SYNC_OUTPUT_FILE) +load_comb_output=$(COMB_OUTPUT_FILE)

regression: $(SIMV)
	rm -rf test_files && mkdir -p test_files && python3 $(TEST_SCRIPT)

clean:
	rm -rf *simv* csrc ucli.key *.vcd $(BITSTREAM_FILE) $(SYNC_OUTPUT_FILE) $(COMB_OUTPUT_FILE) test_files/
