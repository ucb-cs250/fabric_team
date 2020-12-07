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

    fpga250.get_slicel(0, 0).set_lut_config("LUT0", hex_to_bin("000A", 16))
    fpga250.get_slicel(0, 0).set_lut_config("LUT1", hex_to_bin("000C", 16))
    fpga250.get_slicel(0, 0).set_lut_config("LUT2", hex_to_bin("000A", 16))
    fpga250.get_slicel(0, 0).set_lut_config("LUT3", hex_to_bin("000C", 16))
    fpga250.get_slicel(0, 0).set_lut_config("LUT4", hex_to_bin("000A", 16))
    fpga250.get_slicel(0, 0).set_lut_config("LUT5", hex_to_bin("000C", 16))
    fpga250.get_slicel(0, 0).set_lut_config("LUT6", hex_to_bin("000A", 16))
    fpga250.get_slicel(0, 0).set_lut_config("LUT7", hex_to_bin("000C", 16))
    fpga250.get_slicel(0, 0).set_split("S44_3", "1")
    fpga250.get_slicel(0, 0).set_split("S44_2", "1")
    fpga250.get_slicel(0, 0).set_split("S44_1", "1")
    fpga250.get_slicel(0, 0).set_split("S44_0", "1")
    fpga250.get_slicel(0, 0).set_mux_f("00")
    fpga250.get_slicel(0, 0).set_use_cc("1")
    fpga250.get_slicel(0, 0).set_reg_init_val("01001111")
    fpga250.get_slicel(0, 0).set_memset_bit("1")

    fpga250.get_slicel(1, 0).set_lut_config("LUT0", hex_to_bin("ABCD", 16))
    fpga250.get_slicel(1, 0).set_lut_config("LUT1", hex_to_bin("1111", 16))
    fpga250.get_slicel(1, 0).set_lut_config("LUT2", hex_to_bin("ABCD", 16))
    fpga250.get_slicel(1, 0).set_lut_config("LUT3", hex_to_bin("1111", 16))
    fpga250.get_slicel(1, 0).set_lut_config("LUT4", hex_to_bin("ABCD", 16))
    fpga250.get_slicel(1, 0).set_lut_config("LUT5", hex_to_bin("1111", 16))
    fpga250.get_slicel(1, 0).set_lut_config("LUT6", hex_to_bin("ABCD", 16))
    fpga250.get_slicel(1, 0).set_lut_config("LUT7", hex_to_bin("1111", 16))
    fpga250.get_slicel(1, 0).set_split("S44_3", "1")
    fpga250.get_slicel(1, 0).set_split("S44_2", "0")
    fpga250.get_slicel(1, 0).set_split("S44_1", "1")
    fpga250.get_slicel(1, 0).set_split("S44_0", "1")
    fpga250.get_slicel(1, 0).set_mux_f("11")
    fpga250.get_slicel(1, 0).set_use_cc("1")
    fpga250.get_slicel(1, 0).set_reg_init_val("10000001")
    fpga250.get_slicel(1, 0).set_memset_bit("1")

    fpga250.get_slicel(2, 0).set_lut_config("LUT0", hex_to_bin("ABCD", 16))
    fpga250.get_slicel(2, 0).set_lut_config("LUT1", hex_to_bin("1111", 16))
    fpga250.get_slicel(2, 0).set_lut_config("LUT2", hex_to_bin("ABCD", 16))
    fpga250.get_slicel(2, 0).set_lut_config("LUT3", hex_to_bin("1111", 16))
    fpga250.get_slicel(2, 0).set_lut_config("LUT4", hex_to_bin("ABCD", 16))
    fpga250.get_slicel(2, 0).set_lut_config("LUT5", hex_to_bin("1111", 16))
    fpga250.get_slicel(2, 0).set_lut_config("LUT6", hex_to_bin("ABCD", 16))
    fpga250.get_slicel(2, 0).set_lut_config("LUT7", hex_to_bin("1111", 16))
    fpga250.get_slicel(2, 0).set_split("S44_3", "0")
    fpga250.get_slicel(2, 0).set_split("S44_2", "0")
    fpga250.get_slicel(2, 0).set_split("S44_1", "1")
    fpga250.get_slicel(2, 0).set_split("S44_0", "1")
    fpga250.get_slicel(2, 0).set_mux_f("00")
    fpga250.get_slicel(2, 0).set_use_cc("0")
    fpga250.get_slicel(2, 0).set_reg_init_val("10000111")
    fpga250.get_slicel(2, 0).set_memset_bit("1")

    fpga250.get_slicel(3, 0).set_lut_config("LUT0", hex_to_bin("ABCD", 16))
    fpga250.get_slicel(3, 0).set_lut_config("LUT1", hex_to_bin("2222", 16))
    fpga250.get_slicel(3, 0).set_lut_config("LUT2", hex_to_bin("ABCD", 16))
    fpga250.get_slicel(3, 0).set_lut_config("LUT3", hex_to_bin("2222", 16))
    fpga250.get_slicel(3, 0).set_lut_config("LUT4", hex_to_bin("ABCD", 16))
    fpga250.get_slicel(3, 0).set_lut_config("LUT5", hex_to_bin("2222", 16))
    fpga250.get_slicel(3, 0).set_lut_config("LUT6", hex_to_bin("ABCD", 16))
    fpga250.get_slicel(3, 0).set_lut_config("LUT7", hex_to_bin("2222", 16))
    fpga250.get_slicel(3, 0).set_split("S44_3", "1")
    fpga250.get_slicel(3, 0).set_split("S44_2", "1")
    fpga250.get_slicel(3, 0).set_split("S44_1", "1")
    fpga250.get_slicel(3, 0).set_split("S44_0", "1")
    fpga250.get_slicel(3, 0).set_mux_f("11")
    fpga250.get_slicel(3, 0).set_use_cc("1")
    fpga250.get_slicel(3, 0).set_reg_init_val("11111111")
    fpga250.get_slicel(3, 0).set_memset_bit("1")

    fpga250.get_slicel(0, 1).set_lut_config("LUT0", hex_to_bin("FFFF", 16))
    fpga250.get_slicel(0, 1).set_lut_config("LUT1", hex_to_bin("EEEE", 16))
    fpga250.get_slicel(0, 1).set_lut_config("LUT2", hex_to_bin("FFFF", 16))
    fpga250.get_slicel(0, 1).set_lut_config("LUT3", hex_to_bin("EEEE", 16))
    fpga250.get_slicel(0, 1).set_lut_config("LUT4", hex_to_bin("FFFF", 16))
    fpga250.get_slicel(0, 1).set_lut_config("LUT5", hex_to_bin("EEEE", 16))
    fpga250.get_slicel(0, 1).set_lut_config("LUT6", hex_to_bin("FFFF", 16))
    fpga250.get_slicel(0, 1).set_lut_config("LUT7", hex_to_bin("EEEE", 16))
    fpga250.get_slicel(0, 1).set_split("S44_3", "0")
    fpga250.get_slicel(0, 1).set_split("S44_2", "0")
    fpga250.get_slicel(0, 1).set_split("S44_1", "0")
    fpga250.get_slicel(0, 1).set_split("S44_0", "0")
    fpga250.get_slicel(0, 1).set_mux_f("00")
    fpga250.get_slicel(0, 1).set_use_cc("0")
    fpga250.get_slicel(0, 1).set_reg_init_val("00001111")
    fpga250.get_slicel(0, 1).set_memset_bit("1")

    fpga250.get_slicel(0, 2).set_lut_config("LUT0", hex_to_bin("000A", 16))
    fpga250.get_slicel(0, 2).set_lut_config("LUT1", hex_to_bin("000A", 16))
    fpga250.get_slicel(0, 2).set_lut_config("LUT2", hex_to_bin("000A", 16))
    fpga250.get_slicel(0, 2).set_lut_config("LUT3", hex_to_bin("000A", 16))
    fpga250.get_slicel(0, 2).set_lut_config("LUT4", hex_to_bin("000A", 16))
    fpga250.get_slicel(0, 2).set_lut_config("LUT5", hex_to_bin("000A", 16))
    fpga250.get_slicel(0, 2).set_lut_config("LUT6", hex_to_bin("000A", 16))
    fpga250.get_slicel(0, 2).set_lut_config("LUT7", hex_to_bin("000A", 16))
    fpga250.get_slicel(0, 2).set_split("S44_3", "1")
    fpga250.get_slicel(0, 2).set_split("S44_2", "1")
    fpga250.get_slicel(0, 2).set_split("S44_1", "1")
    fpga250.get_slicel(0, 2).set_split("S44_0", "1")
    fpga250.get_slicel(0, 2).set_mux_f("11")
    fpga250.get_slicel(0, 2).set_use_cc("1")
    fpga250.get_slicel(0, 2).set_reg_init_val("11111111")
    fpga250.get_slicel(0, 2).set_memset_bit("1")

#    # East SB -> South SB -> CB_East -> LUT0 (from the East side of the CLB)
#    fpga250.get_sb(0, 0).set_pip("SINGLE", "e", 0, "s", 1)
#    fpga250.get_sb(0, 0).set_pip("SINGLE", "e", 1, "s", 0)
#    fpga250.get_sb(0, 0).set_pip("SINGLE", "e", 2, "s", 3)
#    fpga250.get_sb(0, 0).set_pip("SINGLE", "e", 3, "s", 2)
#
#    fpga250.get_cb_east(0, 0).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 4)
#    fpga250.get_cb_east(0, 0).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 5)
#    fpga250.get_cb_east(0, 0).set_pip("CB_SINGLE0_TO_CLB0_IN", 3, 6)
#    fpga250.get_cb_east(0, 0).set_pip("CB_SINGLE0_TO_CLB0_IN", 2, 7)
#
#    # North SB -> West SB -> CB_North -> LUT6 (from the North side of the CLB)
#    fpga250.get_sb(0, 0).set_pip("SINGLE", "n", 0, "w", 1)
#    fpga250.get_sb(0, 0).set_pip("SINGLE", "n", 1, "w", 0)
#    fpga250.get_sb(0, 0).set_pip("SINGLE", "n", 2, "w", 3)
#    fpga250.get_sb(0, 0).set_pip("SINGLE", "n", 3, "w", 2)
#
#    fpga250.get_cb_north(0, 0).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 4)
#    fpga250.get_cb_north(0, 0).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 5)
#    fpga250.get_cb_north(0, 0).set_pip("CB_SINGLE0_TO_CLB0_IN", 3, 6)
#    fpga250.get_cb_north(0, 0).set_pip("CB_SINGLE0_TO_CLB0_IN", 2, 7)
#
#    # Eastward CLB output -> CB_East -> LUT1 (from the East side of the CLB)
#    fpga250.get_cb_east(0, 0).set_pip("CLB1_OUT_TO_CB_DOUBLE0", 0, 0)
#    fpga250.get_cb_east(0, 0).set_pip("CLB1_OUT_TO_CB_DOUBLE0", 1, 1)
#    fpga250.get_cb_east(0, 0).set_pip("CLB1_OUT_TO_CB_DOUBLE0", 2, 2)
#    fpga250.get_cb_east(0, 0).set_pip("CLB1_OUT_TO_CB_DOUBLE0", 3, 3)
#
#    fpga250.get_cb_east(0, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 0, 0)
#    fpga250.get_cb_east(0, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 1, 1)
#    fpga250.get_cb_east(0, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 2, 2)
#    fpga250.get_cb_east(0, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 3, 3)
#
#    # Northward CLB output -> CB_North -> LUT7 (from the North side of the CLB)
#    fpga250.get_cb_north(0, 0).set_pip("CLB1_OUT_TO_CB_DOUBLE0", 0, 0)
#    fpga250.get_cb_north(0, 0).set_pip("CLB1_OUT_TO_CB_DOUBLE0", 1, 1)
#    fpga250.get_cb_north(0, 0).set_pip("CLB1_OUT_TO_CB_DOUBLE0", 2, 2)
#    fpga250.get_cb_north(0, 0).set_pip("CLB1_OUT_TO_CB_DOUBLE0", 3, 3)
#
#    fpga250.get_cb_north(0, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 0, 0)
#    fpga250.get_cb_north(0, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 1, 1)
#    fpga250.get_cb_north(0, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 2, 2)
#    fpga250.get_cb_north(0, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 3, 3)

    bitstream = fpga250.output_column_wise_bitstream()

    print(bitstream)

    return 0

if __name__ == '__main__':
		main()
