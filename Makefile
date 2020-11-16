
### Examples
# make sim test=sim/clb_with_config_test.v
# make sim test=ix_yukio/testbench/clb_switch_box_tb.v

VCS = vcs

CLB_PATH      = clb_team
CFG_PATH      = config_team
MAC_PATH      = mac_team
SRAM_PATH     = sram_team
IX_YUKIO_PATH = ix_yukio
IX_NATE_PATH  = ix_nate

INCS = src+$(MAC_PATH)/src

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
       $(IX_YUKIO_PATH)/src/clb_switch_box.v \
       $(IX_YUKIO_PATH)/src/universal_switch_box.v \
       $(IX_YUKIO_PATH)/src/switch_box_element_one.v \
       $(IX_YUKIO_PATH)/src/switch_box_element_two.v \
       $(IX_YUKIO_PATH)/src/transmission_gate.v \
       $(IX_YUKIO_PATH)/src/transmission_gate_oneway.v \
       $(IX_YUKIO_PATH)/src/connection_block.v \
       $(SRAM_PATH)/src/behavioral/unit_sram.v \
       $(SRAM_PATH)/src/behavioral/unit_sram_reduced.v \
       src/consts.vh \
       src/fpga_clb_tiles.v 
#       $(MAC_PATH)/src/multiply.v \
#       $(MAC_PATH)/src/accumulate.v \
#       $(MAC_PATH)/src/mac_mul_block_0.v \
#       $(MAC_PATH)/src/mac_mul_block_1.v \
#       $(MAC_PATH)/src/mac_mul_block_2.v \
#       $(MAC_PATH)/src/mac_mul_block_3.v \
#       $(MAC_PATH)/src/mac_cluster.v \
#       $(MAC_PATH)/src/mac_combiner_block.v \
#       $(MAC_PATH)/src/mac_acc_block.v \
#       $(MAC_PATH)/src/mac_mul_negator_block.v \
#       $(MAC_PATH)/src/mac_acc_negator_block.v \
#       $(MAC_PATH)/arithmetic_cells/src/n_bit_adder.v\
#       $(MAC_PATH)/arithmetic_cells/src/n_bit_array_multiplier.v\


OPTS = -notice \
       -PP \
       -line \
       +lint=all,noVCDE,noONGS,noUI \
       +warn=noTMR \
       +v2k \
       +vcs+lic+wait \
       +rad \
       -quiet \
       -sverilog \
       -timescale=1ns/1ps

test = path_to_a_test_bench_file
testname = $(basename $(notdir $(test)))
SIMV = ./$(testname).simv

$(SIMV): $(SRCS) $(test)
	$(VCS) $(OPTS) +incdir+$(INCS) $^ -o $@

sim: $(SIMV)
	$(SIMV) -q +ntb_random_seed_automatic

clean:
	rm -rf *simv* csrc ucli.key *.vcd
