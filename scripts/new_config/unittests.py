from CB import *
from SB import *
from CLB_tile import *
from SliceL import *
from S44 import *
from Fabric import *
from hex_to_binary import *

def test1(fpga250):
    description = '''
      East(0, 0) to West(0, 1)
      Route DFF1(0, 0) to LUT4(0, 1) and LUT5(0, 1)
    '''

    # Init "1" to DFF1
    fpga250.get_slicel(0, 0).set_reg_init_val("00000001")
    fpga250.get_slicel(0, 0).set_memset_bit("1")

    # Route DFF1(0, 0) output to SLICEL(0, 1) LUT5's input
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 0)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 1)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 2)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 3)

    # Route DFF1(0, 0) output to SLICEL(0, 1) LUT4's input
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 4)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 5)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 6)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 7)

    # Setup the logic functions for LUT4(0, 1) and LUT5(0, 1)
    fpga250.get_slicel(0, 1).set_lut_config("LUT4", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(0, 1).set_lut_config("LUT5", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(0, 1).set_split("S44_3", "1")
    fpga250.get_slicel(0, 1).set_split("S44_2", "1")
    fpga250.get_slicel(0, 1).set_split("S44_1", "1")
    fpga250.get_slicel(0, 1).set_split("S44_0", "1")

    # Set the expected outputs
    fpga250.get_slicel(0, 1).set_comb_output("LUT4", "1")
    fpga250.get_slicel(0, 1).set_comb_output("LUT5", "1")

def test2(fpga250):
    description = '''
      East(0, 0) to West(0, 1) through CB_EAST(0, 0)
      Route DFF1(0, 0) to LUT4(0, 1) and LUT5(0, 1) using a single wire of CB_EAST(0, 0)
    '''

    # Init "1" to DFF1
    fpga250.get_slicel(0, 0).set_reg_init_val("00000001")
    fpga250.get_slicel(0, 0).set_memset_bit("1")

    # Route DFF1(0, 0) output to single[0] of CB_EAST(0, 0)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CB_SINGLE0", 2, 0)

    # Route single[0] of CB_EAST(0, 0) output to SLICEL(0, 1) LUT5's input
    fpga250.get_cb_east(0, 0).set_pip("CB_SINGLE0_TO_CLB1_IN", 0, 0)
    fpga250.get_cb_east(0, 0).set_pip("CB_SINGLE0_TO_CLB1_IN", 0, 1)
    fpga250.get_cb_east(0, 0).set_pip("CB_SINGLE0_TO_CLB1_IN", 0, 2)
    fpga250.get_cb_east(0, 0).set_pip("CB_SINGLE0_TO_CLB1_IN", 0, 3)

    # Don't route inputs to SLICEL(0, 1) LUT4

    # Setup the logic functions for LUT4(0, 1) and LUT5(0, 1)
    fpga250.get_slicel(0, 1).set_lut_config("LUT4", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(0, 1).set_lut_config("LUT5", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(0, 1).set_split("S44_3", "1")
    fpga250.get_slicel(0, 1).set_split("S44_2", "1")
    fpga250.get_slicel(0, 1).set_split("S44_1", "1")
    fpga250.get_slicel(0, 1).set_split("S44_0", "1")

    # Set the expected outputs
    fpga250.get_slicel(0, 1).set_comb_output("LUT4", "x")
    fpga250.get_slicel(0, 1).set_comb_output("LUT5", "1")

def test3(fpga250):
    description = '''
      East(0, 0) to West(0, 1) through CB_EAST(0, 0)
      Route DFF1(0, 0) to LUT4(0, 1) and LUT5(0, 1) using a double wire of CB_EAST(0, 0)
    '''

    # Init "1" to DFF1
    fpga250.get_slicel(0, 0).set_reg_init_val("00000001")
    fpga250.get_slicel(0, 0).set_memset_bit("1")

    # Route DFF1(0, 0) output to double[0] of CB_EAST(0, 0)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CB_DOUBLE0", 2, 0)

    # Route double[0] of CB_EAST(0, 0) output to SLICEL(0, 1) LUT4's input
    fpga250.get_cb_east(0, 0).set_pip("CB_DOUBLE0_TO_CLB1_IN", 0, 4)
    fpga250.get_cb_east(0, 0).set_pip("CB_DOUBLE0_TO_CLB1_IN", 0, 5)
    fpga250.get_cb_east(0, 0).set_pip("CB_DOUBLE0_TO_CLB1_IN", 0, 6)
    fpga250.get_cb_east(0, 0).set_pip("CB_DOUBLE0_TO_CLB1_IN", 0, 7)

    # Don't route inputs to SLICEL(0, 1) LUT5

    # Setup the logic functions for LUT4(0, 1) and LUT5(0, 1)
    fpga250.get_slicel(0, 1).set_lut_config("LUT4", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(0, 1).set_lut_config("LUT5", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(0, 1).set_split("S44_3", "1")
    fpga250.get_slicel(0, 1).set_split("S44_2", "1")
    fpga250.get_slicel(0, 1).set_split("S44_1", "1")
    fpga250.get_slicel(0, 1).set_split("S44_0", "1")

    # Set the expected outputs
    fpga250.get_slicel(0, 1).set_comb_output("LUT4", "1")
    fpga250.get_slicel(0, 1).set_comb_output("LUT5", "x")

def test4(fpga250):
    description = '''
      East(0, 0) to North(0, 1) through CB_EAST(0, 0) and SB(0, 0)
      Route DFF0(0, 0) to LUT6(0, 1) and LUT7(0, 1)
    '''

    # Init "1" to DFF0
    fpga250.get_slicel(0, 0).set_reg_init_val("00000010")
    fpga250.get_slicel(0, 0).set_memset_bit("1")

    # Route DFF0(0, 0) output to single[2] of CB_EAST(0, 0)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CB_SINGLE0", 3, 2)

    # Route single[2] of CB_EAST(0, 0) to SB(0, 0) and turn East to single[3] of CB_NORTH(0, 1)
    fpga250.get_sb(0, 0).set_pip("SINGLE", "S", 2, "E", 3)

    # Route single[3] of CB_NORTH(0, 1) to SLICEL(0, 1) LUT7's input
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 3, 0)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 3, 1)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 3, 2)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 3, 3)

    # Route single[3] of CB_NORTH(0, 1) to SLICEL(0, 1) LUT6's input
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 3, 4)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 3, 5)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 3, 6)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 3, 7)

    # Setup the logic functions for LUT6(0, 1) and LUT7(0, 1)
    fpga250.get_slicel(0, 1).set_lut_config("LUT6", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(0, 1).set_lut_config("LUT7", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(0, 1).set_split("S44_3", "1")
    fpga250.get_slicel(0, 1).set_split("S44_2", "1")
    fpga250.get_slicel(0, 1).set_split("S44_1", "1")
    fpga250.get_slicel(0, 1).set_split("S44_0", "1")

    # Set the expected outputs
    fpga250.get_slicel(0, 1).set_comb_output("LUT6", "1")
    fpga250.get_slicel(0, 1).set_comb_output("LUT7", "1")

def test5(fpga250):
    description = '''
      East(0, 0) to East(0, 1) through CB_EAST(0, 0) and SB(0, 0) and CB_NORTH(0, 1)
      and SB(0, 1) and CB_EAST(0, 1)
      Route DFF0(0, 0) to LUT0(0, 1) and LUT1(0, 1)
    '''

    # Init "1" to DFF0
    fpga250.get_slicel(0, 0).set_reg_init_val("00000010")
    fpga250.get_slicel(0, 0).set_memset_bit("1")

    # Route DFF0(0, 0) output to single[1] of CB_EAST(0, 0)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CB_SINGLE0", 3, 1)

    # Route single[1] of CB_EAST(0, 0) to SB(0, 0) and turn East to single[0] of CB_NORTH(0, 1)
    fpga250.get_sb(0, 0).set_pip("SINGLE", "S", 1, "E", 0)

    # Route single[0] of CB_EAST(0, 1) to SB(0, 1) and turn South to single[0] of CB_EAST(0, 1)
    fpga250.get_sb(0, 1).set_pip("SINGLE", "W", 0, "S", 0)

    # Route single[0] of CB_EAST(0, 1) to SLICEL(0, 1) LUT1's input
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 0)
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 1)
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 2)
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 3)

    # Route single[0] of CB_EAST(0, 1) to SLICEL(0, 1) LUT0's input
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 4)
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 5)
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 6)
    fpga250.get_cb_east(0, 1).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 7)

    # Setup the logic functions for LUT0(0, 1) and LUT1(0, 1)
    fpga250.get_slicel(0, 1).set_lut_config("LUT0", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(0, 1).set_lut_config("LUT1", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(0, 1).set_split("S44_3", "1")
    fpga250.get_slicel(0, 1).set_split("S44_2", "1")
    fpga250.get_slicel(0, 1).set_split("S44_1", "1")
    fpga250.get_slicel(0, 1).set_split("S44_0", "1")

    # Set the expected outputs
    fpga250.get_slicel(0, 1).set_comb_output("LUT0", "1")
    fpga250.get_slicel(0, 1).set_comb_output("LUT1", "1")

def test6(fpga250):
    description = '''
      East(0, 0) to South(1, 1)
      Route DFF0(0, 0) to LUT2(1, 1) and LUT3(1, 1)
    '''
    # Init "1" to DFF0
    fpga250.get_slicel(0, 0).set_reg_init_val("00000010")
    fpga250.get_slicel(0, 0).set_memset_bit("1")

    # Route DFF0(0, 0) to single[0] of CB_EAST(0, 0)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CB_SINGLE0", 3, 0)

    # Route single[0] of CB_EAST(0, 0) to single[1] of CB_NORTH(0, 1) through SB(0, 0)
    fpga250.get_sb(0, 0).set_pip("SINGLE", "S", 0, "E", 1)

    # Route single[1] of CB_EAST(0, 1) to LUT3(1, 1)'s inputs
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 0)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 1)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 2)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 3)

    # Route single[1] of CB_EAST(0, 1) to LUT2(1, 1)'s inputs
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 4)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 5)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 6)
    fpga250.get_cb_north(0, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 7)

    # Setup the logic functions for LUT2(0, 1) and LUT3(0, 1)
    fpga250.get_slicel(1, 1).set_lut_config("LUT2", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(1, 1).set_lut_config("LUT3", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(1, 1).set_split("S44_3", "1")
    fpga250.get_slicel(1, 1).set_split("S44_2", "1")
    fpga250.get_slicel(1, 1).set_split("S44_1", "1")
    fpga250.get_slicel(1, 1).set_split("S44_0", "1")

    # Set the expected outputs
    fpga250.get_slicel(1, 1).set_comb_output("LUT2", "1")
    fpga250.get_slicel(1, 1).set_comb_output("LUT3", "1")

def test7(fpga250):
    description = '''
      East(0, 0) to East(1, 0) using direct double wire
      Route DFF0(0, 0) to LUT1(1, 0)
    '''

    # Init "1" to DFF0
    fpga250.get_slicel(0, 0).set_reg_init_val("00000010")
    fpga250.get_slicel(0, 0).set_memset_bit("1")

    # Route DFF0(0, 0) to double[0] of CB_EAST(0, 0)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CB_DOUBLE0", 3, 0)

    # double[0] of CB_EAST(0, 0) directly connects to double[4] of CB_EAST(1, 0)
    # (skipping SB(0, 0))
    # Route the double[0] wire of CB_EAST(1, 0) to LUT1's (1, 0) inputs
    fpga250.get_cb_east(1, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 4, 0)
    fpga250.get_cb_east(1, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 4, 1)
    fpga250.get_cb_east(1, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 4, 2)
    fpga250.get_cb_east(1, 0).set_pip("CB_DOUBLE0_TO_CLB0_IN", 4, 3)

    # Don't route any inputs to LUT0's (1, 0) input

    # Setup the logic functions for LUT0(0, 1) and LUT1(0, 1)
    fpga250.get_slicel(1, 0).set_lut_config("LUT0", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(1, 0).set_lut_config("LUT1", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(1, 0).set_split("S44_3", "1")
    fpga250.get_slicel(1, 0).set_split("S44_2", "1")
    fpga250.get_slicel(1, 0).set_split("S44_1", "1")
    fpga250.get_slicel(1, 0).set_split("S44_0", "1")

    # Set the expected outputs
    fpga250.get_slicel(1, 0).set_comb_output("LUT0", "x")
    fpga250.get_slicel(1, 0).set_comb_output("LUT1", "1")

def test8(fpga250):
    description = '''
      Test the forwarding input of S44
      Route DFF0(1, 1) to LUT4(1, 2)
      Route DFF1(1, 1) to LUT5(1, 2)
    '''

    # Init "1" to DFF0 and "0" to DFF1 (1, 1)
    fpga250.get_slicel(1, 1).set_reg_init_val("00000010")
    fpga250.get_slicel(1, 1).set_memset_bit("1")

    # Route DFF0(1, 1) to LUT4(1, 2)'s inputs through CB_EAST(1, 1)
    fpga250.get_cb_east(1, 1).set_pip("CLB0_OUT_TO_CLB1_IN", 3, 4)
    fpga250.get_cb_east(1, 1).set_pip("CLB0_OUT_TO_CLB1_IN", 3, 5)
    fpga250.get_cb_east(1, 1).set_pip("CLB0_OUT_TO_CLB1_IN", 3, 6)
    fpga250.get_cb_east(1, 1).set_pip("CLB0_OUT_TO_CLB1_IN", 3, 7)

    # Route DFF1(1, 1) to LUT5(1, 2)'s inputs through CB_EAST(1, 1)
    fpga250.get_cb_east(1, 1).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 0)
    fpga250.get_cb_east(1, 1).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 1)
    fpga250.get_cb_east(1, 1).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 2)
    fpga250.get_cb_east(1, 1).set_pip("CLB0_OUT_TO_CLB1_IN", 2, 3) # We expect that this input won't be used

    # Setup the logic functions for LUT4(0, 1) and LUT5(0, 1)
    fpga250.get_slicel(1, 2).set_lut_config("LUT4", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(1, 2).set_lut_config("LUT5", hex_to_bin("FFFE", 16)) # 4-OR
    # Turn off split here, so that the output of LUT0 goes to LUT1's I3
    fpga250.get_slicel(1, 2).set_split("S44_2", "0")

    # Set the expected outputs
    fpga250.get_slicel(1, 2).set_comb_output("LUT4", "1")
    fpga250.get_slicel(1, 2).set_comb_output("LUT5", "1")

def test9(fpga250):
    description = '''
      Test ClockEnable
      Route DFF1(1, 1) to LUT5(2, 1) for inputs
      Route DFF3(1, 1) to CLB(2, 1) CE input
    '''

    # Init "1" to DFF1 and DFF3 (1, 1)
    fpga250.get_slicel(1, 1).set_reg_init_val("00000101")
    fpga250.get_slicel(1, 1).set_memset_bit("1")

    # Route DFF1(1, 1) to single[0] of CB_EAST(1, 1)
    fpga250.get_cb_east(1, 1).set_pip("CLB0_OUT_TO_CB_SINGLE0", 2, 0)

    # Route single[0] from south to north through SB(1, 1)
    fpga250.get_sb(1, 1).set_pip("SINGLE", "S", 0, "N", 0)

    # Route single[0] from south to west through SB(2, 1)
    fpga250.get_sb(2, 1).set_pip("SINGLE", "S", 0, "W", 0)

    # Route single[0] to single[1] from east to south through SB(2, 0)
    fpga250.get_sb(2, 0).set_pip("SINGLE", "E", 0, "S", 1)

    # Route single[1] of CB_EAST(2, 0) to LUT5's inputs (2, 0)
    fpga250.get_cb_east(2, 0).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 0)
    fpga250.get_cb_east(2, 0).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 1)
    fpga250.get_cb_east(2, 0).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 2)
    fpga250.get_cb_east(2, 0).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 3)

    # Next, we route DFF3(1, 1) as the CE signal to CLB(2, 1)
    # Route DFF3(1, 1) to single[0] of CB_NORTH(0, 1)
    fpga250.get_cb_north(0, 1).set_pip("CLB1_OUT_TO_CB_SINGLE0", 2, 0)

    # Route single[0] to single[0] from east to north through SB(0, 0)
    fpga250.get_sb(0, 0).set_pip("SINGLE", "E", 0, "N", 0)

    # Route single[0] to single[1] from south to east through SB(1, 0)
    fpga250.get_sb(1, 0).set_pip("SINGLE", "S", 0, "E", 1)

    # Route single[1] to CLB(2, 1) to input 8 (REG_CE)
    fpga250.get_cb_north(1, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 8)

    # Setup the logic functions for LUT5(2, 1)
    fpga250.get_slicel(2, 1).set_lut_config("LUT5", hex_to_bin("8000", 16)) # 4-AND
    fpga250.get_slicel(2, 1).set_split("S44_2", "1")

    # Set the expected outputs
    fpga250.get_slicel(2, 1).set_comb_output("LUT5", "1")

    # DFF5 should register the output of LUT5
    fpga250.get_slicel(2, 1).set_sync_output("DFF5", "1")
    # The remaining DFFs should just be 'x' since their corresponding LUTs
    # do not provide any sensible output
    fpga250.get_slicel(2, 1).set_sync_output("DFF0", "x")
    fpga250.get_slicel(2, 1).set_sync_output("DFF1", "x")
    fpga250.get_slicel(2, 1).set_sync_output("DFF2", "x")
    fpga250.get_slicel(2, 1).set_sync_output("DFF3", "x")
    fpga250.get_slicel(2, 1).set_sync_output("DFF4", "x")
    fpga250.get_slicel(2, 1).set_sync_output("DFF6", "x")
    fpga250.get_slicel(2, 1).set_sync_output("DFF7", "x")

def test10(fpga250):
    description = '''
      Test Carry
          {DFF7(0, 0), DFF6(0, 0), DFF1(0, 0), DFF0(0, 0)} +
          {DFF7(0, 1), DFF6(0, 1), DFF1(0, 1), DFF0(0, 1)}
      -> CLB(2, 2)
    '''

    # Init DFFs
    fpga250.get_slicel(0, 0).set_reg_init_val("00000000")
    fpga250.get_slicel(0, 0).set_memset_bit("1")
    fpga250.get_slicel(0, 1).set_reg_init_val("00000000")
    fpga250.get_slicel(0, 1).set_memset_bit("1")

    fpga250.get_slicel(0, 0).set_sync_output("DFF7", "0")
    fpga250.get_slicel(0, 0).set_sync_output("DFF6", "1")
    fpga250.get_slicel(0, 0).set_sync_output("DFF1", "1")
    fpga250.get_slicel(0, 0).set_sync_output("DFF0", "0")

    fpga250.get_slicel(0, 1).set_sync_output("DFF7", "0")
    fpga250.get_slicel(0, 1).set_sync_output("DFF6", "0")
    fpga250.get_slicel(0, 1).set_sync_output("DFF1", "0")
    fpga250.get_slicel(0, 1).set_sync_output("DFF0", "1")

    # Route DFF0(0, 0) and DFF0(0, 1) to LUT1(2, 2) and LUT0(2, 2)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CB_SINGLE0", 3, 0)
    fpga250.get_sb(0, 0).set_pip("SINGLE", "S", 0, "N", 0)
    fpga250.get_sb(1, 0).set_pip("SINGLE", "S", 0, "N", 0)
    fpga250.get_sb(2, 0).set_pip("SINGLE", "S", 0, "E", 1)
    fpga250.get_sb(2, 1).set_pip("SINGLE", "W", 1, "E", 1)
    fpga250.get_sb(2, 2).set_pip("SINGLE", "E", 1, "S", 0)
    fpga250.get_cb_east(2, 2).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 0)
    fpga250.get_cb_east(2, 2).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 4)

    fpga250.get_cb_east(2, 2).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 2) # this is actually "dont-care"
    fpga250.get_cb_east(2, 2).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 3) # this is actually "dont-care"
    fpga250.get_cb_east(2, 2).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 6) # this is actually "dont-care"
    fpga250.get_cb_east(2, 2).set_pip("CB_SINGLE0_TO_CLB0_IN", 0, 7) # this is actually "dont-care"

    fpga250.get_cb_east(0, 1).set_pip("CLB0_OUT_TO_CB_SINGLE0", 3, 1)
    fpga250.get_sb(0, 1).set_pip("SINGLE", "S", 1, "N", 1)
    fpga250.get_sb(1, 1).set_pip("SINGLE", "S", 1, "N", 1)
    fpga250.get_sb(2, 1).set_pip("SINGLE", "S", 1, "E", 0)
    fpga250.get_sb(2, 2).set_pip("SINGLE", "E", 0, "S", 1)
    fpga250.get_cb_east(2, 2).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 1)
    fpga250.get_cb_east(2, 2).set_pip("CB_SINGLE0_TO_CLB0_IN", 1, 5)

    # Route DFF1(0, 0) and DFF1(0, 1) to LUT3(2, 2) and LUT2(2, 2)
    fpga250.get_cb_east(0, 0).set_pip("CLB0_OUT_TO_CB_SINGLE0", 2, 2)
    fpga250.get_sb(0, 0).set_pip("SINGLE", "S", 2, "N", 2)
    fpga250.get_sb(1, 0).set_pip("SINGLE", "S", 2, "E", 3)
    fpga250.get_sb(1, 1).set_pip("SINGLE", "W", 3, "E", 3)
    fpga250.get_cb_north(1, 2).set_pip("CB_SINGLE0_TO_CLB1_IN", 3, 0)
    fpga250.get_cb_north(1, 2).set_pip("CB_SINGLE0_TO_CLB1_IN", 3, 4)

    fpga250.get_cb_north(1, 2).set_pip("CB_SINGLE0_TO_CLB1_IN", 3, 2) # this is actually "dont-care"
    fpga250.get_cb_north(1, 2).set_pip("CB_SINGLE0_TO_CLB1_IN", 3, 3) # this is actually "dont-care"
    fpga250.get_cb_north(1, 2).set_pip("CB_SINGLE0_TO_CLB1_IN", 3, 6) # this is actually "dont-care"
    fpga250.get_cb_north(1, 2).set_pip("CB_SINGLE0_TO_CLB1_IN", 3, 7) # this is actually "dont-care"

    fpga250.get_cb_east(0, 1).set_pip("CLB0_OUT_TO_CB_SINGLE0", 2, 3)
    fpga250.get_sb(0, 1).set_pip("SINGLE", "S", 3, "N", 3)
    fpga250.get_sb(1, 1).set_pip("SINGLE", "S", 3, "E", 2)
    fpga250.get_cb_north(1, 2).set_pip("CB_SINGLE0_TO_CLB1_IN", 2, 1)
    fpga250.get_cb_north(1, 2).set_pip("CB_SINGLE0_TO_CLB1_IN", 2, 5)

    # Route DFF6(0, 0) and DFF6(0, 1) to LUT5(2, 2) and LUT4(2, 2)
    fpga250.get_cb_north(0, 0).set_pip("CLB0_OUT_TO_CB_SINGLE0", 3, 0)
    fpga250.get_sb(0, 0).set_pip("SINGLE", "W", 0, "N", 1)
    fpga250.get_sb(1, 0).set_pip("SINGLE", "S", 1, "N", 1)
    fpga250.get_sb(2, 0).set_pip("SINGLE", "S", 1, "E", 0)
    fpga250.get_sb(2, 1).set_pip("SINGLE", "E", 0, "S", 1)
    fpga250.get_cb_east(2, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 0)
    fpga250.get_cb_east(2, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 4)

    fpga250.get_cb_east(2, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 2) # this is actually "dont-care"
    fpga250.get_cb_east(2, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 3) # this is actually "dont-care"
    fpga250.get_cb_east(2, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 6) # this is actually "dont-care"
    fpga250.get_cb_east(2, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 1, 7) # this is actually "dont-care"

    fpga250.get_cb_north(0, 1).set_pip("CLB0_OUT_TO_CB_SINGLE0", 3, 1)
    fpga250.get_sb(0, 1).set_pip("SINGLE", "W", 1, "N", 0)
    fpga250.get_sb(1, 1).set_pip("SINGLE", "S", 0, "N", 0)
    fpga250.get_cb_east(2, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 0, 1)
    fpga250.get_cb_east(2, 1).set_pip("CB_SINGLE0_TO_CLB1_IN", 0, 5)

    # Route DFF7(0, 0) and DFF7(0, 1) to LUT7(2, 2) and LUT6(2, 2)
    fpga250.get_cb_north(0, 0).set_pip("CLB0_OUT_TO_CB_SINGLE0", 2, 2)
    fpga250.get_sb(0, 0).set_pip("SINGLE", "W", 2, "E", 2)
    fpga250.get_sb(0, 1).set_pip("SINGLE", "W", 2, "E", 2)
    fpga250.get_sb(0, 2).set_pip("SINGLE", "W", 2, "E", 2)
    fpga250.get_sb(0, 3).set_pip("SINGLE", "W", 2, "N", 3)
    fpga250.get_sb(1, 3).set_pip("SINGLE", "S", 3, "N", 3)
    fpga250.get_sb(2, 3).set_pip("SINGLE", "S", 3, "N", 3)
    fpga250.get_sb(3, 3).set_pip("SINGLE", "S", 3, "W", 2)
    fpga250.get_sb(3, 2).set_pip("SINGLE", "W", 2, "S", 2)
    fpga250.get_sb(2, 2).set_pip("SINGLE", "N", 2, "W", 3)
    fpga250.get_cb_north(2, 2).set_pip("CB_SINGLE0_TO_CLB_SINGLE0", 3, 0)
    fpga250.get_cb_north(2, 2).set_pip("CB_SINGLE0_TO_CLB_SINGLE0", 3, 4)

    fpga250.get_cb_north(2, 2).set_pip("CB_SINGLE0_TO_CLB_SINGLE0", 3, 2) # this is actually "dont-care"
    fpga250.get_cb_north(2, 2).set_pip("CB_SINGLE0_TO_CLB_SINGLE0", 3, 3) # this is actually "dont-care"
    fpga250.get_cb_north(2, 2).set_pip("CB_SINGLE0_TO_CLB_SINGLE0", 3, 6) # this is actually "dont-care"
    fpga250.get_cb_north(2, 2).set_pip("CB_SINGLE0_TO_CLB_SINGLE0", 3, 7) # this is actually "dont-care"

    fpga250.get_cb_north(0, 1).set_pip("CLB0_OUT_TO_CB_SINGLE0", 2, 3)
    fpga250.get_sb(0, 1).set_pip("SINGLE", "W", 3, "E", 3)
    fpga250.get_sb(0, 2).set_pip("SINGLE", "W", 3, "E", 3)
    fpga250.get_sb(0, 3).set_pip("SINGLE", "W", 3, "N", 2)
    fpga250.get_sb(1, 3).set_pip("SINGLE", "S", 2, "N", 2)
    fpga250.get_sb(2, 3).set_pip("SINGLE", "S", 2, "N", 2)
    fpga250.get_sb(3, 3).set_pip("SINGLE", "S", 2, "W", 3)
    fpga250.get_sb(3, 2).set_pip("SINGLE", "W", 3, "S", 3)
    fpga250.get_sb(2, 2).set_pip("SINGLE", "N", 3, "W", 2)
    fpga250.get_cb_north(2, 2).set_pip("CB_SINGLE0_TO_CLB_SINGLE0", 2, 1)
    fpga250.get_cb_north(2, 2).set_pip("CB_SINGLE0_TO_CLB_SINGLE0", 2, 5)

    # Setup the logic functions for LUTs in CLB(2, 2)
    fpga250.get_slicel(2, 2).set_lut_config("LUT1", hex_to_bin("8888", 16)) # 2-AND
    fpga250.get_slicel(2, 2).set_lut_config("LUT0", hex_to_bin("6666", 16)) # 2-XOR
    fpga250.get_slicel(2, 2).set_lut_config("LUT3", hex_to_bin("8888", 16)) # 2-AND
    fpga250.get_slicel(2, 2).set_lut_config("LUT2", hex_to_bin("6666", 16)) # 2-XOR
    fpga250.get_slicel(2, 2).set_lut_config("LUT5", hex_to_bin("8888", 16)) # 2-AND
    fpga250.get_slicel(2, 2).set_lut_config("LUT4", hex_to_bin("6666", 16)) # 2-XOR
    fpga250.get_slicel(2, 2).set_lut_config("LUT7", hex_to_bin("8888", 16)) # 2-AND
    fpga250.get_slicel(2, 2).set_lut_config("LUT6", hex_to_bin("6666", 16)) # 2-XOR

    fpga250.get_slicel(2, 2).set_split("S44_0", "1")
    fpga250.get_slicel(2, 2).set_split("S44_1", "1")
    fpga250.get_slicel(2, 2).set_split("S44_2", "1")
    fpga250.get_slicel(2, 2).set_split("S44_3", "1")
    fpga250.get_slicel(2, 2).set_use_cc("1")

    # Set the expected outputs
    fpga250.get_slicel(2, 2).set_comb_output("CARRY", "0111")

def main():
    MX = 3
    MY = 4
    WS = 4
    WD = 8
    S_XX_BASE = 4
    debug = False

    fpga250 = Fabric(MY, MX, WS, WD, S_XX_BASE, debug=debug, top_level_debug=debug)

    #test0(fpga250)
    #test1(fpga250)
    #test2(fpga250)
    #test3(fpga250)
    #test4(fpga250)
    #test5(fpga250)
    #test6(fpga250)
    #test7(fpga250)
    #test8(fpga250)
    #test9(fpga250)
    test10(fpga250)

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
