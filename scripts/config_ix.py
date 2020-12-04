
import collections
import os
import sys
from enum import Enum
from optparse import OptionParser


from models_ix import *

def proof_of_concept_test():

    # Fabric instantiation: a fabric module is an array of CLB tiles
    # Each CLB tile has a SLICEL (CLB), two ConnectionBlocks (one East, one North),
    # and one Switchbox. Check out the fabric's README for the general layout
    # We need to specify the number of columns and the number of rows

    # This should contain 12 CLB tiles
    fabric = Fabric(4, 3) # 4 rows, 3 columns

    # Get the CLB at tile (Y=1, X=2)
    slicel12 = fabric.get_slicel(1, 2)
    # Get the SB at tile (Y=1, X=2)
    sb12 = fabric.get_sb(1, 2)
    # Get the ConnectionBlock (east) at tile (Y=1, X=2)
    cb_east12 = fabric.get_cb_east(1, 2)
    # Get the ConnectionBlock (north) at tile (Y=1, X=2)
    cb_north12 = fabric.get_cb_north(1, 2)

    # For SLICEL, we have 8 LUTs with the following LUT ordering
    # (left is MSB, right is LSB)
    # LUT6, LUT7, LUT4, LUT5, LUT2, LUT3, LUT0, LUT1
    # {LUT0 -> LUT1} is the first S44-LUT. I/O facing to the East
    # {LUT2 -> LUT3} is the second S44-LUT. I/O facing to the South
    # {LUT4 -> LUT5} is the third S44-LUT. I/O facing to the West
    # {LUT6 -> LUT7} is the fourth S44-LUT. I/O facing to the North

    # We can configure a LUT similar to what you did with the ConfiguredSliceL,
    # or something as simple as follows
    # This will configure LUT0 from SLICEL(1, 2)
    lut0_slicel12 = slicel12.set_config_bit, LUT0, "8000") # This is a 4-input AND

    # There are also other config bits, such as the soft-mux connection (inside
    # an S44-LUT), use_inter_lut, use_carry, register initial values. We should
    # provide separate methods to set them. I think that would provide us more
    # flexibility -- rather than setting a whole SLICEL config bitchain at a time


    # for example, this should activate carry chain usage
    cc = slicel12.set_config_bit, CC, "1")

    # Default will be 0 if an instance is not explicitly set    

    # Same things for all the flip-flops
    # You may add other methods that you deem necessary or handy for setting the config bits

  
  
  
    # Next is Routing. We would like to have some way of encoding a routing path
    # from one pin to another. The routing path should contain all the correct
    # PIPs that set the path properly inside CBs or SBs to route data from
    # source to sink

    # Generally, for our architecture, the following things are adopted
    # 4 SINGLE WIRES: SINGLE0, SINGLE1, SINGLE2, SINGLE3
    # 8 DOUBLE WIRES: DOUBLE{0-7}
    # A CLB input pin can connect to any SINGLE or DOUBLE wires of a ConnectionBlock
    # that it is facing to
    # For example, the LUT0 input pins {I0, I1, I2, I3} can connect to any SINGLE
    # or DOUBLE wires of CB_East of the same tile, since LUT0 is located in the
    # East side
    # Regarding CLT output pins, one can connect to any SINGLE wires of a ConnectionBlock
    # that it is facing to. However, for DOUBLE wires, only DOUBLE{0-3} are accessible
    # to a CLB ouput pin

    # Here is an example of how to write a routing path
    # This will route the output of LUT1 (CLB_tile(1, 3)) to the input I1 of LUT1 (CLB_tile(3, 3))
    cb_east12.set_pip(CLB0_OUT_TO_SINGLE2) # Route the CLB0_OUT (LUT1's output) to the SINGLE2 wire
    sb12.set_pip(S0E1, 1) # Turn East (using the second pair of the switch-box-element-two, hence we have "1" here)
    sb13.set_pip(W1N1, 1) # From West to North, bypass CB_North(1, 3)
    sb23.set_pip(S1N1, 1) # From South to North, bypass CB_East(2, 3)
    cb_east33.set_pip(SINGLE2_TO_CLB0_IN1) # Route the SINGLE2 wire to CLB0_IN1 (LUT1's input pin I1)

    # Here are the PIPs
    # Per Connection Block
    # CLB0_* refers to the CLB of the same tile
    # CLB1_* refers to the CLB of the adjacent tile (East of CB_east, North if CB_north)
    # Note that we define that a ConnectionBlock has access to up to 12 CLB inputs and 5 CLB outputs.
    # This config might change, but shouldn't be a problem for our purpose now
    # It would be better if they are parameterized and not hardcoded

    CLB0_OUT{0_4}_TO_SINGLE0, CLB0_OUT{0_4}_TO_SINGLE1, CLB0_OUT{0_4}_TO_SINGLE2, CLB0_OUT{0_4}_TO_SINGLE3 
    CLB1_OUT{0_4}_TO_SINGLE0, CLB1_OUT{0_4}_TO_SINGLE1, CLB1_OUT{0_4}_TO_SINGLE2, CLB1_OUT{0_4}_TO_SINGLE3 
    CLB0_OUT{0_4}_TO_DOUBLE0, CLB0_OUT{0_4}_TO_DOUBLE1, CLB0_OUT{0_4}_TO_DOUBLE2, CLB0_OUT{0_4}_TO_DOUBLE3
    CLB1_OUT{0_4}_TO_DOUBLE0, CLB1_OUT{0_4}_TO_DOUBLE1, CLB1_OUT{0_4}_TO_DOUBLE2, CLB1_OUT{0_4}_TO_DOUBLE3

    SINGLE0_TO_CLB0_IN{0-11}
    SINGLE1_TO_CLB0_IN{0-11}
    SINGLE2_TO_CLB0_IN{0-11}
    SINGLE3_TO_CLB0_IN{0-11}
    SINGLE0_TO_CLB1_IN{0-11}
    SINGLE1_TO_CLB1_IN{0-11}
    SINGLE2_TO_CLB1_IN{0-11}
    SINGLE3_TO_CLB1_IN{0-11}

    DOUBLE0_TO_CLB0_IN{0-11}
    DOUBLE1_TO_CLB0_IN{0-11}
    DOUBLE2_TO_CLB0_IN{0-11}
    DOUBLE3_TO_CLB0_IN{0-11}
    DOUBLE4_TO_CLB0_IN{0-11}
    DOUBLE5_TO_CLB0_IN{0-11}
    DOUBLE6_TO_CLB0_IN{0-11}
    DOUBLE7_TO_CLB0_IN{0-11}

    DOUBLE0_TO_CLB1_IN{0-11}
    DOUBLE1_TO_CLB1_IN{0-11}
    DOUBLE2_TO_CLB1_IN{0-11}
    DOUBLE3_TO_CLB1_IN{0-11}
    DOUBLE5_TO_CLB1_IN{0-11}
    DOUBLE6_TO_CLB1_IN{0-11}
    DOUBLE7_TO_CLB1_IN{0-11}
    DOUBLE8_TO_CLB1_IN{0-11}

    # Per Switchbox
    # should be similar to what you did so far. We want to be able to turn corner, or go straight
    # And we don't use Switchbox element-1 for now. Just element-2 to keep things simple
    # (the number of wires is even)

    # Regarding CB and CLB connectivity, the following convention is adopted
    # It might provide you some reference when doing routing

    # CLB East input pins (Y, X) and CB_east (Y, X)
    LUT1_I0 (Y, X) -- CLB0_IN0 (Y, X)
    LUT1_I1 (Y, X) -- CLB0_IN1 (Y, X)
    LUT1_I2 (Y, X) -- CLB0_IN2 (Y, X)
    LUT1_I3 (Y, X) -- CLB0_IN3 (Y, X)
    LUT0_I0 (Y, X) -- CLB0_IN4 (Y, X)
    LUT0_I1 (Y, X) -- CLB0_IN5 (Y, X)
    LUT0_I2 (Y, X) -- CLB0_IN6 (Y, X)
    LUT0_I3 (Y, X) -- CLB0_IN7 (Y, X)

    # CLB South input pins (Y, X) and CB_north (Y, X) -- note that we use CLB1_* here since it is from an adjacent tile
    LUT3_I0 (Y, X) -- CLB1_IN0 (Y-1, X)
    LUT3_I1 (Y, X) -- CLB1_IN1 (Y-1, X)
    LUT3_I2 (Y, X) -- CLB1_IN2 (Y-1, X)
    LUT3_I3 (Y, X) -- CLB1_IN3 (Y-1, X)
    LUT2_I0 (Y, X) -- CLB1_IN4 (Y-1, X)
    LUT2_I1 (Y, X) -- CLB1_IN5 (Y-1, X)
    LUT2_I2 (Y, X) -- CLB1_IN6 (Y-1, X)
    LUT2_I3 (Y, X) -- CLB1_IN7 (Y-1, X)

    # CLB West input pins (Y, X) and CB_east (Y, X-1) -- note that we use CLB1_* here since it is from an adjacent tile
    LUT5_I0 (Y, X) -- CLB1_IN0 (Y, X-1)
    LUT5_I1 (Y, X) -- CLB1_IN1 (Y, X-1)
    LUT5_I2 (Y, X) -- CLB1_IN2 (Y, X-1)
    LUT5_I3 (Y, X) -- CLB1_IN3 (Y, X-1)
    LUT4_I0 (Y, X) -- CLB1_IN4 (Y, X-1)
    LUT4_I1 (Y, X) -- CLB1_IN5 (Y, X-1)
    LUT4_I2 (Y, X) -- CLB1_IN6 (Y, X-1)
    LUT4_I3 (Y, X) -- CLB1_IN7 (Y, X-1)

    # CLB East input pins (Y, X) and CB_north (Y, X)
    LUT7_I0 (Y, X) -- CLB0_IN0 (Y, X)
    LUT7_I1 (Y, X) -- CLB0_IN1 (Y, X)
    LUT7_I2 (Y, X) -- CLB0_IN2 (Y, X)
    LUT7_I3 (Y, X) -- CLB0_IN3 (Y, X)
    LUT6_I0 (Y, X) -- CLB0_IN4 (Y, X)
    LUT6_I1 (Y, X) -- CLB0_IN5 (Y, X)
    LUT6_I2 (Y, X) -- CLB0_IN6 (Y, X)
    LUT6_I3 (Y, X) -- CLB0_IN7 (Y, X)

    # CLB*_IN{8, 9, 10, 11, 12} reserves for REG_CE, MUX_INS, CONFIG_BIT/CONFIG_SET. But let's not worry about them now

    # Now, CLB East output pins (Y, X) to CB_east (Y, X)
    # Note that comb output means either LUT output or CarryChain output (if use_cc is enable)
    LUT1_O / CC_S0 -- COMB_O0 (Y, X) -- CLB0_OUT0 (Y, X)
    LUT0_O         -- COMB_O1 (Y, X) -- CLB0_OUT1 (Y, X)
    DFF1_Q         -- SYNC_O0 (Y, X) -- CLB0_OUT2 (Y, X)
    DFF0_Q         -- SYNC_O1 (Y, X) -- CLB0_OUT3 (Y, X)

    # CLB South output pins (Y, X) to CB_north (Y-1, X) -- note that we use CLB1_* here since it is from an adjacent tile
    LUT3_O / CC_S1 -- COMB_O2 (Y, X) -- CLB1_OUT0 (Y-1, X)
    LUT2_O         -- COMB_O3 (Y, X) -- CLB1_OUT1 (Y-1, X)
    DFF3_Q         -- SYNC_O2 (Y, X) -- CLB1_OUT2 (Y-1, X)
    DFF2_Q         -- SYNC_O3 (Y, X) -- CLB1_OUT3 (Y-1, X)

    # CLB West output pins (Y, X) to CB_east (Y, X - 1) -- note that we use CLB1_* here since it is from an adjacent tile
    LUT5_O / CC_S2 -- COMB_O4 (Y, X) -- CLB1_OUT0 (Y, X-1)
    LUT4_O         -- COMB_O5 (Y, X) -- CLB1_OUT1 (Y, X-1)
    DFF5_Q         -- SYNC_O4 (Y, X) -- CLB1_OUT2 (Y, X-1)
    DFF4_Q         -- SYNC_O5 (Y, X) -- CLB1_OUT3 (Y, X-1)

    # CLB North output pins (Y, X) to CB_north (Y, X)
    LUT7_O / CC_S3 -- COMB_O6 (Y, X) -- CLB0_OUT0 (Y, X)
    LUT6_O         -- COMB_O7 (Y, X) -- CLB0_OUT0 (Y, X)
    DFF7_Q         -- SYNC_O6 (Y, X) -- CLB0_OUT0 (Y, X)
    DFF6_Q         -- SYNC_O7 (Y, X) -- CLB0_OUT1 (Y, X)

    # It might be a good idea to have some built-in check method to mark a PIP
    # after it is set, so that we don't set it again when we route another path
    # This could easily happen as we do things by hand and forget to keep track
    # This also helps to verify the imported placed-and-routed solution from other tool

    # Once we are happy, have a method to emit the final bitstream
    # The final bitstream should organized as follows (MSB is left, LSB is right)
    # <bitstream_clb_tiles_col0> <bitstream_clb_tiles_col1> ... <bitstream_clb_tiles_colN>
    #
    # For each column bitstream, we have (MSB->LSB)
    # <clb_tile_N> <clb_tile_N-1> ... <clb_tile_0>

    # For each CLB_tile, we have (MSB->LSB)
    # <cb_east> <sb> <cb_north> <slicel>

    # For a SLICEL, we have (MSB->LSB)
    # <use_cc> <mux_f> <soft_conn_S44_3> <lut_0_S44_3> <lut_1_S44_3> 
    #                  <soft_conn_S44_2> <lut_0_S44_2> <lut_1_S44_2>
    #                  <soft_conn_S44_1> <lut_0_S44_1> <lut_1_S44_1>
    #                  <soft_conn_S44_0> <lut_0_S44_0> <lut_1_S44_0>

def main():
    # step 1: define base configs
    switch_box_element_one_config = generate_config("switch_box_element_one_config")
    switch_box_element_two_config = generate_config("switch_box_element_two_config")

    # step 2: define an active mapping (could be read from text file)
    # users need to obey the conventional that smaller indexed node always appear first for bidirectional switches
    example_active_mapping_1 = [("n0","e0"), ("s0","e0"), ("e0","w0")]
    example_active_mapping_2 = [("n0","w1"), ("n0","e0"), ("s0","w0"), ("e0","w0")]
    example_active_mapping_3 = [("n0","w1"), ("n0","e0"), ("s0","w0"), ("e0","w0"), ("dn0","dw1"), ("dn0","de0"), ("ds0","dw0"), ("de0","dw0")]

    # step 3: instantiate the model that will be using
    sb_element_one = SwitchBoxElementOne()
    sb_element_two = SwitchBoxElementTwo()
    universal_sb_even_width = UniversalSwitchBox(2) 
    universal_sb_odd_width = UniversalSwitchBox(3) 
    clb_sb_even_ws = CLBSwitchBox(4,2)
    clb_sb_odd_ws = CLBSwitchBox(5,2)

    # test 1: instantiate a mapping onto sb_element_one
    sb_element_one_0 = InstantiatedSwitchBox(sb_element_one, example_active_mapping_1)
    # generate the mapping & output the bitstream
    sb_element_one_0.map_input_to_config()
    print(sb_element_one_0.output_bitstream())

    # test 2: instantiate a mapping onto sb_element_two
    sb_element_two_0 = InstantiatedSwitchBox(sb_element_two, example_active_mapping_2)
    # generate the mapping & output the bitstream
    sb_element_two_0.map_input_to_config()
    print(sb_element_two_0.output_bitstream())

    # test 3: instantiate a mapping onto universal_sb_even_width
    sb_univ_even_0 = InstantiatedSwitchBox(universal_sb_even_width, example_active_mapping_2)
    # generate the mapping & output the bitstream
    sb_univ_even_0.map_input_to_config()
    print(sb_univ_even_0.output_bitstream())

    # test 4: instantiate a mapping onto universal_sb_odd_width
    sb_univ_odd_0 = InstantiatedSwitchBox(universal_sb_odd_width, example_active_mapping_2)
    # generate the mapping & output the bitstream
    sb_univ_odd_0.map_input_to_config()
    print(sb_univ_odd_0.output_bitstream())

    # test 5: instantiate a mapping onto clb_switch_box, WS is even
    sb_clb_ws_even_0 = InstantiatedSwitchBox(clb_sb_even_ws, example_active_mapping_3)
    # generate the mapping & output the bitstream
    sb_clb_ws_even_0.map_input_to_config()
    print(sb_clb_ws_even_0.output_bitstream())

    # test 6: instantiate a mapping onto clb_switch_box, WS is even
    sb_clb_ws_odd_0 = InstantiatedSwitchBox(clb_sb_odd_ws, example_active_mapping_3)
    # generate the mapping & output the bitstream
    sb_clb_ws_odd_0.map_input_to_config()
    print(sb_clb_ws_odd_0.output_bitstream())

    # test 7: fabric test
    fab_0 = Fabric()
    fab_0.add_element(sb_element_one_0, 4)
    fab_0.add_element(sb_element_two_0, 3)
    fab_0.add_element(sb_univ_even_0, 2)
    fab_0.add_element(sb_univ_odd_0, 10)
    fab_0.add_element(sb_clb_ws_even_0, 12)
    fab_0.add_element(sb_clb_ws_odd_0, 20)
    print(fab_0.output_bitstream())

    # tentative:
    s = ConfiguredS44(4, False, str(1), "1100110011001100", "0011001100001111")
    print(s.output_bitstream())

    ss = ConfiguredS44(4, True,)
    print(ss.output_bitstream())

    params = dict()
    params["s_xx_base"] = 4
    params["num_luts"] = 4
    slicel = ConfiguredSliceL(params, True, True,)
    print(slicel.output_bitstream())

if __name__ == '__main__':
    main()
