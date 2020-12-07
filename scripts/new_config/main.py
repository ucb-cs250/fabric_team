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

    fpga250 = Fabric(MX, MY, WS, WD, S_XX_BASE, debug=True, top_level_debug=True)
    slicel_00   = fpga250.get_slicel(0, 0)
    sb_00       = fpga250.get_sb(0, 0)
    cb_east_00  = fpga250.get_cb_east(0, 0)
    cb_north_00 = fpga250.get_cb_north(0, 0)

    slicel_00.set_lut_config("LUT0", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT1", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT2", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT3", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT4", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT5", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT6", hex_to_bin("8000", 16))
    slicel_00.set_lut_config("LUT7", hex_to_bin("8000", 16))
    slicel_00.set_split("S44_3", "1")
    slicel_00.set_split("S44_2", "1")
    slicel_00.set_split("S44_1", "1")
    slicel_00.set_split("S44_0", "1")
    slicel_00.set_mux_f("00")
    slicel_00.set_use_cc("0")
    slicel_00.set_reg_init_val("11110011")
    slicel_00.set_memset_bit("1")

    # East SB -> South SB -> CB_East -> LUT0 (from the East side of the CLB)
    sb_00.set_pip("SINGLE", "e", 0, "s", 1)
    sb_00.set_pip("SINGLE", "e", 1, "s", 0)
    sb_00.set_pip("SINGLE", "e", 2, "s", 3)
    sb_00.set_pip("SINGLE", "e", 3, "s", 2)

    cb_east_00.set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 4)
    cb_east_00.set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 5)
    cb_east_00.set_pip("CB_SINGLE0_TO_CLB0_IN", 3, 6)
    cb_east_00.set_pip("CB_SINGLE0_TO_CLB0_IN", 2, 7)

    # North SB -> West SB -> CB_North -> LUT6 (from the North side of the CLB)
    sb_00.set_pip("SINGLE", "n", 0, "w", 1)
    sb_00.set_pip("SINGLE", "n", 1, "w", 0)
    sb_00.set_pip("SINGLE", "n", 2, "w", 3)
    sb_00.set_pip("SINGLE", "n", 3, "w", 2)

    cb_north_00.set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 4)
    cb_north_00.set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 5)
    cb_north_00.set_pip("CB_SINGLE0_TO_CLB0_IN", 3, 6)
    cb_north_00.set_pip("CB_SINGLE0_TO_CLB0_IN", 2, 7)

    # Eastward CLB output -> CB_East -> LUT1 (from the East side of the CLB)
    cb_east_00.set_pip("CLB1_OUT_TO_CB_DOUBLE0", 0, 0)
    cb_east_00.set_pip("CLB1_OUT_TO_CB_DOUBLE0", 1, 1)
    cb_east_00.set_pip("CLB1_OUT_TO_CB_DOUBLE0", 2, 2)
    cb_east_00.set_pip("CLB1_OUT_TO_CB_DOUBLE0", 3, 3)

    cb_east_00.set_pip("CB_DOUBLE0_TO_CLB0_IN", 0, 0)
    cb_east_00.set_pip("CB_DOUBLE0_TO_CLB0_IN", 1, 1)
    cb_east_00.set_pip("CB_DOUBLE0_TO_CLB0_IN", 2, 2)
    cb_east_00.set_pip("CB_DOUBLE0_TO_CLB0_IN", 3, 3)

    # Northward CLB output -> CB_North -> LUT7 (from the North side of the CLB)
    cb_north_00.set_pip("CLB1_OUT_TO_CB_DOUBLE0", 0, 0)
    cb_north_00.set_pip("CLB1_OUT_TO_CB_DOUBLE0", 1, 1)
    cb_north_00.set_pip("CLB1_OUT_TO_CB_DOUBLE0", 2, 2)
    cb_north_00.set_pip("CLB1_OUT_TO_CB_DOUBLE0", 3, 3)

    cb_north_00.set_pip("CB_DOUBLE0_TO_CLB0_IN", 0, 0)
    cb_north_00.set_pip("CB_DOUBLE0_TO_CLB0_IN", 1, 1)
    cb_north_00.set_pip("CB_DOUBLE0_TO_CLB0_IN", 2, 2)
    cb_north_00.set_pip("CB_DOUBLE0_TO_CLB0_IN", 3, 3)

    bitstream = fpga250.output_bitstream()
    print(bitstream)

    return 0

if __name__ == '__main__':
		main()
