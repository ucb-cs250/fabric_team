from CB import *
from SB import *
from CLB_tile import *
from SliceL import *
from S44 import *
from Fabric import *
from hex_to_binary import *

def main():
    MX = 3
    MY = 4
    WS = 4
    WD = 8
    S_XX_BASE = 4
    debug = False

    fpga250 = Fabric(MY, MX, WS, WD, S_XX_BASE, debug=debug, top_level_debug=debug)

    fpga250.get_slicel(0, 0).set_reg_init_val("11000001")
    fpga250.get_slicel(0, 0).set_memset_bit("1")

    fpga250.get_slicel(0, 1).set_comb_output("LUT0", "1")
    fpga250.get_slicel(0, 1).set_comb_output("LUT1", "1")
    fpga250.get_slicel(0, 1).set_comb_output("LUT4", "1")
    fpga250.get_slicel(0, 1).set_comb_output("LUT5", "1")
    fpga250.get_slicel(0, 1).set_comb_output("LUT6", "1")
    fpga250.get_slicel(0, 1).set_comb_output("LUT7", "1")

    fpga250.get_slicel(1, 0).set_comb_output("LUT0", "1")
    fpga250.get_slicel(1, 0).set_comb_output("LUT1", "1")
    fpga250.get_slicel(1, 0).set_comb_output("LUT2", "1")
    fpga250.get_slicel(1, 0).set_comb_output("LUT3", "1")

    fpga250.get_slicel(0, 1).set_lut_config("LUT0", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(0, 1).set_lut_config("LUT1", hex_to_bin("8000", 16))
    fpga250.get_slicel(0, 1).set_lut_config("LUT4", hex_to_bin("8000", 16))
    fpga250.get_slicel(0, 1).set_lut_config("LUT5", hex_to_bin("8000", 16))
    fpga250.get_slicel(0, 1).set_lut_config("LUT6", hex_to_bin("8000", 16))
    fpga250.get_slicel(0, 1).set_lut_config("LUT7", hex_to_bin("8000", 16))
    fpga250.get_slicel(0, 1).set_split("S44_3", "1")
    fpga250.get_slicel(0, 1).set_split("S44_2", "1")
    fpga250.get_slicel(0, 1).set_split("S44_1", "1")
    fpga250.get_slicel(0, 1).set_split("S44_0", "1")
    fpga250.get_slicel(0, 1).set_mux_f("00")
    fpga250.get_slicel(0, 1).set_use_cc("0")
    fpga250.get_slicel(0, 1).set_reg_init_val("00000000")
    fpga250.get_slicel(0, 1).set_memset_bit("1")

    fpga250.get_slicel(1, 0).set_lut_config("LUT0", hex_to_bin("8000", 16))
    fpga250.get_slicel(1, 0).set_lut_config("LUT1", hex_to_bin("8000", 16))
    fpga250.get_slicel(1, 0).set_lut_config("LUT2", hex_to_bin("8000", 16))
    fpga250.get_slicel(1, 0).set_lut_config("LUT3", hex_to_bin("8000", 16))
    fpga250.get_slicel(1, 0).set_split("S44_3", "1")
    fpga250.get_slicel(1, 0).set_split("S44_2", "1")
    fpga250.get_slicel(1, 0).set_split("S44_1", "1")
    fpga250.get_slicel(1, 0).set_split("S44_0", "1")
    fpga250.get_slicel(1, 0).set_mux_f("00")
    fpga250.get_slicel(1, 0).set_use_cc("0")
    fpga250.get_slicel(1, 0).set_reg_init_val("00000000")
    fpga250.get_slicel(1, 0).set_memset_bit("1")

    # Route (0, 0) DFF1 to (0, 1) LUT4, LUT5
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 0)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 1)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 2)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 3)

    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 4)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 5)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 6)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 7)

    # Route (0, 0) DFF7 to (1, 0) LUT2, LUT3
    fpga250.get_cb_north(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 0)
    fpga250.get_cb_north(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 1)
    fpga250.get_cb_north(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 2)
    fpga250.get_cb_north(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 3)

    fpga250.get_cb_north(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 4)
    fpga250.get_cb_north(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 5)
    fpga250.get_cb_north(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 6)
    fpga250.get_cb_north(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 7)

    # Route (0, 0) DFF1 to single[0] wire
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CB_SINGLE0", 2, 0)

    # Route single[0] to single[1] South to East (SB(0, 0) -> CB_NORTH(0, 1))
    fpga250.get_sb(0, 0).set_pip("SINGLE", "S", 0, "E", 1)

    # Route (0, 1) CB_NORTH to LUT6, LUT 7
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 0)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 1)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 2)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 3)

    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 4)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 5)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 6)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 7)

    # Route single[1] to single[1] West to South (SB(0, 1) -> CB_EAST(0, 1))
    fpga250.get_sb(0, 1).set_pip("SINGLE", "W", 1, "S", 1)

    # Route (0, 1) CB_EAST to LUT0, LUT1
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 0)
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 1)
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 2)
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 3)

    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 4)
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 5)
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 6)
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 7)

    # Route (0, 0) DFF1 to DOUBLE3
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CB_DOUBLE0", 2, 3)
    # DOUBLE3 goes straight to DOUBLE7 of CB_EAST(1, 0) (skip SB(0, 0))
    # Route (1, 0) DOUBLE7 to LUT0, LUT1
    fpga250.get_cb_east(1, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 4+3, 0)
    fpga250.get_cb_east(1, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 4+3, 1)
    fpga250.get_cb_east(1, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 4+3, 2)
    fpga250.get_cb_east(1, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 4+3, 3)
    fpga250.get_cb_east(1, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 4+3, 4)
    fpga250.get_cb_east(1, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 4+3, 5)
    fpga250.get_cb_east(1, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 4+3, 6)
    fpga250.get_cb_east(1, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 4+3, 7)

    bitstream = fpga250.output_column_wise_bitstream()
    comb_output = fpga250.dump_comb_output()
    sync_output = fpga250.dump_sync_output()

    bitstream_file = open("bitstream.txt", "w")
    bitstream_file.write(bitstream)
    comb_output_file = open("comb_output.txt", "w")
    comb_output_file.write(comb_output)
    sync_output_file = open("sync_output.txt", "w")
    sync_output_file.write(sync_output)

    bitstream_file.close()
    comb_output_file.close()
    sync_output_file.close()

if __name__ == '__main__':
		main()
