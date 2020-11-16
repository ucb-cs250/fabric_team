vcs_clock_period = 1.6
input_delay = 0$(shell echo "scale=4; ${vcs_clock_period}*0.2" | bc)

base_dir = $(abspath $(CURDIR)/..)

skywater_cells_dir :=   ${PDK_ROOT}/skywater-pdk/libraries/${PDK_VARIANT}/latest/cells
skywater_fa_dir :=	$(skywater_cells_dir)/fa
skywater_fa_src :=	$(skywater_fa_dir)/sky130_fd_sc_hd__fa.v
mac_cells_dir := 	$(base_dir)/mac_team/arithmetic_cells/src
mac_cells_src :=	$(mac_cells_dir)/n_bit_array_multiplier.v \
			$(mac_cells_dir)/n_bit_adder.v
mac_src_dir := 		$(base_dir)/mac_team/src
# mac_src :=  		$(wildcard $(mac_src_dir)/*.v) \
# 			$(wildcard $(mac_src_dir)/*.vh)
mac_src :=  		$(mac_src_dir)/multiply.v \
			$(mac_src_dir)/accumulate.v \
			$(mac_src_dir)/mac_acc_block.v \
			$(mac_src_dir)/mac_acc_negator_block.v \
			$(mac_src_dir)/mac_cluster.v \
			$(mac_src_dir)/mac_combiner_block.v \
			$(mac_src_dir)/mac_const.vh \
			$(mac_src_dir)/mac_mul_block_0.v \
			$(mac_src_dir)/mac_mul_block_1.v \
			$(mac_src_dir)/mac_mul_block_2.v \
			$(mac_src_dir)/mac_mul_block_3.v \
			$(mac_src_dir)/mac_mul_negator_block.v
ix_src_dir := 		$(base_dir)/ix_yukio/src
ix_src 	:= 		$(wildcard $(ix_src_dir)/*.v) \
			$(wildcard $(ix_src_dir)/*.vh)
fabric_src_dir :=	$(base_dir)/src
fabric_src := 		$(wildcard $(fabric_src_dir)/*.v) \
			$(wildcard $(fabric_src_dir)/*.vh)
config_src_dir :=	$(base_dir)/config_team/src/behavioral
config_src := 		$(wildcard $(config_src_dir)/*.v) \
			$(wildcard $(config_src_dir)/*.vh)

tb_dir = $(base_dir)/testbench
sim_rundir := ./sim-rundir

top := mac_tile_tb
tb := $(tb_dir)/$(top).v

sim_vsrcs := \
  	$(skywater_fa_src) \
 	$(mac_cells_src) \
  	$(mac_src) \
	$(ix_src) \
	$(fabric_src) \
	$(config_src) \
	$(tb) \

VCS = vcs -full64
VCS_OPTS = -notice -line +lint=all,noVCDE,noONGS,noUI -error=PCWM-L -timescale=1ns/10ps -quiet \
	+warn=noTMR \
	+incdir+$(skywater_fa_dir) \
	+incdir+$(mac_cells_dir) \
	+incdir+$(mac_src_dir) \
	+incdir+$(ix_src_dir) \
	+incdir+$(fabric_src_dir) \
	+incdir+$(config_src_dir) \
	+v2k +vcs+lic+wait \
	+vcs+initreg+random \
	+rad \
	+vcs+loopdetect \
	-v2005 \
	-debug_pp \
	+vcs+vcdpluson \
	+define+INPUT_DELAY=$(input_delay) \
	+define+CLOCK_PERIOD=$(vcs_clock_period) \
	$(sim_vsrcs) \

#	+vcs+loopreport \
# +warn=none disables warnings


# Compile the simulator.
simv = $(sim_rundir)/simv
.PHONY: $(simv)
$(simv):
	@echo $(base_dir)
	mkdir -p $(sim_rundir) && \
	cd $(sim_rundir) && \
	$(VCS) $(VCS_OPTS) -o $(notdir $@) -top $(top) \
	+define+DEBUG -debug_pp \

# Run the simulator.
.PHONY: $(simv)-exec
$(simv)-exec: $(simv)
	$(simv) -q +ntb_random_seed_automatic

# run the testbenches
test:	$(simv)-exec

# clean up the directory
clean:
	rm -rf $(sim_rundir) ucli.key
