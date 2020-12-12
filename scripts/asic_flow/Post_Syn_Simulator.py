from pathlib import Path
from Cell_Extractor import *

# this module simulates the netlist after synthesis using a testbench
class Post_Syn_Simulator():

    # init
    def __init__(self, makefile_path, src_list, lib_list, tb_name):
        self.makefile_path = Path(makefile_path)
        self.src_list = src_list
        self.lib_list = lib_list
        self.tb_name = tb_name

    def run(self):
        # first construct the makefile
        with open(str(self.makefile_path / "Makefile"), "w") as f:
            # 1.0 VCS
            f.write("VCS = vcs -full64\n")
            f.write("\n")

            # 1.1 PATHs
            f.write("CLB_PATH      = clb_team\n")
            f.write("CFG_PATH      = config_team\n")
            f.write("MAC_PATH      = mac_team\n")
            f.write("SRAM_PATH     = sram_team\n")
            f.write("IX_YUKIO_PATH = ix_yukio\n")
            f.write("IX_NATE_PATH  = ix_nate\n")
            f.write("\n")

            # 1.2 File locations
            f.write("INCS = src+$(MAC_PATH)/src\n")
            f.write("COMB_OUTPUT_FILE=comb_output.txt\n")
            f.write("SYNC_OUTPUT_FILE=sync_output.txt\n")
            f.write("BITSTREAM_FILE=bitstream.txt\n")
            f.write("UNITTESTS=scripts/new_config/unittests.py\n")
            f.write("TEST_SCRIPT=scripts/new_config/main.py\n")
            f.write("\n")

            # 2. SRC files
            for index, i in enumerate(self.src_list):
                if index == 0:
                    f.write("SRCS = ")
                else:
                    f.write("       ")
                f.write(i + "\\\n")
            f.write("\n")

            # 3. SRC files
            for index, i in enumerate(self.lib_list):
                if index == 0:
                    f.write("SKY130_CELLS = ")
                else:
                    f.write("       ")
                f.write(i + "\\\n")
            f.write("\n")

            # 4. Options
            f.write("OPTS = -notice \\\n")
            f.write("       -line \\\n")
            f.write("       +lint=all,noVCDE,noONGS,noUI \\\n")
            f.write("       +warn=noTMR \\\n")
            f.write("       +v2k \\\n")
            f.write("       +vcs+lic+wait \\\n")
            f.write("       +rad \\\n")
            f.write("       -quiet \\\n")
            f.write("       -sverilog \\\n")
            f.write("       +error+100 \\\n")
            f.write("       -timescale=1ns/1ps \\\n")             
            f.write("       +vcs+vcdpluson\n")             
              
            f.write("\n")

            # 5. tests
            f.write("test = path_to_a_test_bench_file\n")
            f.write("testname = $(basename $(notdir $(test)))\n")
            f.write("\n")

            # 6. SIMV
            f.write("SIMV = ./$(testname).simv\n")
            f.write("\n")

            # 6. Build SIMV
            f.write("$(SIMV): $(SRCS) $(SKY130_CELLS) $(test)\n")     
            f.write("   $(VCS) $(OPTS) +incdir+$(INCS) $^ -o $@\n")      
            f.write("\n")

            # 7. build bitstream file
            f.write("$(BITSTREAM_FILE): $(UNITTESTS)\n")
            f.write("	python $(UNITTESTS)\n")   
            f.write("\n")

            # 8.1 define rule sim
            f.write("sim: $(SIMV) $(BITSTREAM_FILE)\n")
            f.write("	$(SIMV) -q +ntb_random_seed_automatic +load_config=$(BITSTREAM_FILE) +load_sync_output=$(SYNC_OUTPUT_FILE) +load_comb_output=$(COMB_OUTPUT_FILE)\n")
            f.write("\n")

            # 8.2 define rule regression
            f.write("regression: $(SIMV)\n")
            f.write("	rm -rf test_files && mkdir -p test_files && python $(TEST_SCRIPT)\n")
            f.write("\n")
            
            # 8.3 define rule clean
            f.write("clean:\n")
            f.write("	rm -rf *simv* csrc ucli.key *.vcd $(BITSTREAM_FILE) $(SYNC_OUTPUT_FILE) $(COMB_OUTPUT_FILE) test_files/")

    def report(self):
        pass



if __name__ == "__main__":
    makefile_path = "./"
    src_list = ["$(CLB_PATH)/src/behavioral/lut.v",
                "$(CLB_PATH)/src/behavioral/lut_sXX_softcode.v",
                "$(CLB_PATH)/src/behavioral/carry_chain.v",
                "$(CLB_PATH)/src/behavioral/block_config_latches.v",
                "$(CLB_PATH)/src/behavioral/mux_f_slice.v",
                "$(CLB_PATH)/src/behavioral/slicel.v",
                "$(CFG_PATH)/src/behavioral/config_sram_data.v",
                "$(CFG_PATH)/src/behavioral/config_latch.v",
                "$(CFG_PATH)/src/behavioral/config_tile.v",
                "$(CFG_PATH)/src/behavioral/shift_chain.v",
                "$(CFG_PATH)/src/behavioral/wishbone_configuratorinator.v",
                "$(IX_YUKIO_PATH)/src/clb_switch_box.v",
                "$(IX_YUKIO_PATH)/src/universal_switch_box.v",
                "$(IX_YUKIO_PATH)/src/switch_box_element_one.v",
                "$(IX_YUKIO_PATH)/src/switch_box_element_two.v",
                "$(IX_YUKIO_PATH)/src/transmission_gate.v",
                "$(IX_YUKIO_PATH)/src/transmission_gate_oneway.v",
                "$(IX_YUKIO_PATH)/src/connection_block.v",
                "$(IX_YUKIO_PATH)/src/transmission_gate_cell.v",
                "src/baked/baked_slicel.v",
                "src/baked/baked_clb_switch_box.v",
                "src/baked/baked_connection_block.v",
                "src/baked/baked_connection_block_east.v",
                "src/baked/baked_connection_block_north.v",
                "src/clb_tile.v",
                "src/fpga.v"]

    foundry_path = '../skywater-pdk'
    third_party_path = '../thirdparty'
    extractor = Cell_Extractor('./yosys_3.stat.rpt', foundry_path, third_party_path, 'clb_tile', debug=False)
    extractor.parse()
    extractor.extract()
    
    lib_list = extractor.result_list
    tb_name = "toplevel"

    a = Post_Syn_Simulator(makefile_path, src_list, lib_list, tb_name)
    a.run()