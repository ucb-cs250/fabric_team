
### Examples
# make sim test=testbench/clb_with_config_test.v
# make sim test=ix_yukio/testbench/clb_switch_box_tb.v

VCS = vcs -full64

CLB_PATH      = clb_team
CFG_PATH      = config_team
MAC_PATH      = mac_team
SRAM_PATH     = sram_team
IX_YUKIO_PATH = ix_yukio
IX_NATE_PATH  = ix_nate

INCS = src+$(MAC_PATH)/src

COMB_OUTPUT_FILE=comb_output.txt
SYNC_OUTPUT_FILE=sync_output.txt
GPIO_OUTPUT_FILE=gpio_output.txt
BITSTREAM_FILE=bitstream.txt
UNITTESTS=scripts/new_config/unittests.py
TEST_SCRIPT=scripts/new_config/main.py
MK_GEN_SCRIPT=scripts/asic_flow/Cell_Extractor.py
SYNTHESIS_REPORT=cell_netlists/clb_tile/yosys_3.stat.rpt \
                 cell_netlists/wishbone_configuratorinator_00/yosys_3.stat.rpt \
                 cell_netlists/wishbone_configuratorinator_10/yosys_3.stat.rpt \
                 cell_netlists/fpga/yosys_2.stat.rpt

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
       $(IX_YUKIO_PATH)/unidir_src/clb_switch_box.v \
       $(IX_YUKIO_PATH)/unidir_src/connection_block.v \
       $(IX_YUKIO_PATH)/unidir_src/universal_switch_box.v \
       $(IX_YUKIO_PATH)/unidir_src/switch_box_element_one.v \
       $(IX_YUKIO_PATH)/unidir_src/switch_box_element_two.v \
       $(IX_YUKIO_PATH)/util/mux2.v \
       $(IX_YUKIO_PATH)/util/mux4.v \
       $(IX_YUKIO_PATH)/util/muxn.v \
       $(CFG_PATH)/src/wrapped/wishbone_configuratorinator_00.v \
       $(CFG_PATH)/src/wrapped/wishbone_configuratorinator_10.v \
       src/baked/baked_slicel.v \
       src/baked/baked_clb_switch_box_unidir.v \
       src/baked/baked_connection_block_unidir.v \
       src/baked/baked_connection_block_east_unidir.v \
       src/baked/baked_connection_block_north_unidir.v \
       src/clb_tile_unidir.v \
       src/fpga_unidir.v \

GATE_SRCS = cell_netlists/clb_tile/clb_tile.synthesis.v \
            cell_netlists/wishbone_configuratorinator_00/wishbone_configuratorinator_00.synthesis.v \
            cell_netlists/wishbone_configuratorinator_10/wishbone_configuratorinator_10.synthesis.v \
            cell_netlists/fpga/fpga.synthesis.v \
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
#       +vcs+vcdpluson

test = path_to_a_test_bench_file
testname = $(basename $(notdir $(test)))
SIMV = ./$(testname).simv
GATE_SIMV = ./$(testname)_gate.simv

SKY130_CELLS_D_MK = sky130_cells_dep.mk
-include $(SKY130_CELLS_D_MK)

$(SIMV): $(SRCS) $(test)
	$(VCS) $(OPTS) +incdir+$(INCS) $^ -o $@

$(GATE_SIMV): $(GATE_SRCS) $(SKY130_CELLS) $(test)
	$(VCS) $(OPTS) +incdir+$(INCS)+$(SKY130_INCS) +define+FUNCTIONAL+UNIT_DELAY="#0"+GATE_LV $^ -o $@

$(BITSTREAM_FILE): $(UNITTESTS)
	python3 $(UNITTESTS)

sim-rtl: $(SIMV) $(BITSTREAM_FILE)
	$(SIMV) -q +ntb_random_seed_automatic +load_config=$(BITSTREAM_FILE) +load_sync_output=$(SYNC_OUTPUT_FILE) +load_comb_output=$(COMB_OUTPUT_FILE) +load_gpio_output=$(GPIO_OUTPUT_FILE)

$(SKY130_CELLS_D_MK): $(MK_GEN_SCRIPT) $(SYNTHESIS_REPORT)
	python3 $(MK_GEN_SCRIPT) $(SYNTHESIS_REPORT)

sim-gl: $(SKY130_CELLS_D_MK) $(GATE_SIMV) $(BITSTREAM_FILE)
	$(GATE_SIMV) -q +ntb_random_seed_automatic +load_config=$(BITSTREAM_FILE) +load_sync_output=$(SYNC_OUTPUT_FILE) +load_comb_output=$(COMB_OUTPUT_FILE) +load_gpio_output=$(GPIO_OUTPUT_FILE)

regression-rtl: $(SIMV)
	rm -rf test_files && mkdir -p test_files && python3 $(TEST_SCRIPT) $(SIMV)

regression-gl: $(GATE_SIMV)
	rm -rf test_files && mkdir -p test_files && python3 $(TEST_SCRIPT) $(GATE_SIMV)

clean:
	rm -rf *simv* csrc ucli.key *.vcd *.vpd $(BITSTREAM_FILE) $(SYNC_OUTPUT_FILE) $(COMB_OUTPUT_FILE) $(GPIO_OUTPUT_FILE) test_files/
