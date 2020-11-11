
import collections
import os
import sys
from enum import Enum
from optparse import OptionParser


from models_ix import *


def main():
    # an example config
    switch_box_element_one_config = generate_config("switch_box_element_one_config")

    # an example mapping (could be read from text file)
    # users need to obey the conventional that smaller indexed node always appear first for bidirectional switches
    example_active_mapping = [(1,4), (1,3), (2,4), (3,4)]

    # create an active SwitchBoxElementOne instance
    sb_element_one_0 = SwitchBox(switch_box_element_one_config, example_active_mapping)
    # generate the mapping
    sb_element_one_0.map_input_to_config()
    # output the bitstream
    print(sb_element_one_0.output_bitstream())

    # an example config
    switch_box_element_two_config = generate_config("switch_box_element_two_config")

    example_active_mapping = [(1,5), (3,6), (4,8), (5,7)]

    # create an active SwitchBoxElementOne instance
    sb_element_two_0 = SwitchBox(switch_box_element_two_config, example_active_mapping)
    # generate the mapping
    sb_element_two_0.map_input_to_config()
    # output the bitstream
    print(sb_element_two_0.output_bitstream())


if __name__ == '__main__':
    main()