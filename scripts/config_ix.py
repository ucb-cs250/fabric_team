
import collections
import os
import sys
from enum import Enum
from optparse import OptionParser


from models_ix import *


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


if __name__ == '__main__':
    main()