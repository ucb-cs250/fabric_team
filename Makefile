
VCS = vcs

CLB_SRC_PATH = clb_team/src/behavioral
CFG_SRC_PATH = config_team/src/behavioral
MAC_SRC_PATH = mac_team
IX_YUKIO_SRC_PATH = ix_yukio
IX_NATE_SRC_PATH  = ix_nate

SRCS = $(CLB_SRC_PATH)/lut.v \
       $(CLB_SRC_PATH)/lut_sXX_softcode.v \
       $(CLB_SRC_PATH)/carry_chain.v \
       $(CLB_SRC_PATH)/block_config_latches.v \
       $(CLB_SRC_PATH)/mux_f_slice.v \
       $(CLB_SRC_PATH)/slicel.v \
       $(CFG_SRC_PATH)/config_sram_data.v \
       $(CFG_SRC_PATH)/config_latch.v \
       $(CFG_SRC_PATH)/config_tile.v \
       $(CFG_SRC_PATH)/shift_chain.v

OPTS = -notice \
       -PP \
       -line \
       +lint=all,noVCDE,noONGS,noUI \
       +warn=noTMR \
       -error=PCWM-L \
       +v2k \
       +vcs+lic+wait \
       +rad \
       -quiet \
       -v2005 \
       -timescale=1ns/1ps

SIMV_CLB_TEST = ./clb_test.simv

$(SIMV_CLB_TEST): $(SRCS) sim/clb_with_config_tb.v
	$(VCS) $(OPTS) $(SRCS) sim/clb_with_config_tb.v -o $(SIMV_CLB_TEST)

clb_config_test: $(SIMV_CLB_TEST)
	$(SIMV_CLB_TEST) -q +ntb_random_seed_automatic

clean:
	rm -rf *.simv* csrc ucli.key
