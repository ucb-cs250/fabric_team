VCS = vcs -full64

INCS = ./


SRCS = sim/clb_tile_testbench.v \
       carrychain.v \
       cb_with_cfg.v \
       clb.v \
       config_block.v \
       fpga250.v \
       lut4.v \
       mux2.v \
       mux4.v \
       registers.v \
       sb_with_cfg.v \
       cb.v \
       clb_tile.v \
       clb_with_cfg.v \
       dff.v \
       latch.v \
       luts44.v \
       mux2_cfg.v \
       mux4_cfg.v \
       muxn.v \
       sb.v

all: sim-rtl

# Bare minimum required VCS flag
VCS_OPTS = -sverilog

SIMV = ./test.simv

$(SIMV): $(SRCS)
	$(VCS) $(VCS_OPTS) +incdir+$(INCS) $(SRCS) -o $@

sim-rtl: $(SIMV)
	$(SIMV) -q +ntb_random_seed_automatic

clean:
	rm -rf *simv* csrc ucli.key *.elf *.bin *.vcd *.log *.vvp
