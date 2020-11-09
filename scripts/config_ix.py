
import collections
import os
import sys

# elements for a given config
class Config():
    # five important things we need for a switch box element
    # 1. the width of the connections
    # 2. the available nodes
    # 3. the mapping from node to node (indexed by config bit location)
    # 4. the directioness of the switches
    def __init__(self, instance_name, data_width, nodes, switches, bidirectional):
        self.instance_name = instance_name
        self.data_width = data_width
        self.nodes = nodes 
        self.switches = switches
        self.bidirectional = bidirectional 

    # print all asepcts of this config
    def show(self):
        pass     

# model this switch box
class SwitchBoxElementOne():
    # model the switch box based on existing config and user input
    def __init__(self, config, active_mapping):
        self.config = config
        self.active_mapping = active_mapping
        self.bitstream = [None] * len(config.switches)

    # map the active config to the given config
    def map_input_to_config(self):
        switches = self.config.switches
        for index, edge in enumerate(switches):
            # assume the user follows the naming convention
            if edge in self.active_mapping:
                self.bitstream[index] = 1    
            else:
                self.bitstream[index] = 0

    # generate the bistream for this configured element
    def output_bitstream(self):
        result = ""
        for bit in self.bitstream:
            result += str(bit)
        return result

def main():
    # an example config
    switch_box_element_one_config = Config(
        'switch_box_element_one_config',
        1,
        {1:"north", 2:"south", 3:"east", 4:"west"},
        [(1,3), (2,3), (2,4), (1,4), (1,2), (3,4)],
        True
    )

    # an example mapping (could be read from text file)
    # users need to obey the conventional that smaller indexed node always appear first for bidirectional switches
    example_active_mapping = [(1,4), (1,3), (2,4)]

    # create an active SwitchBoxElementOne instance
    sb_element_one_0 = SwitchBoxElementOne(switch_box_element_one_config, example_active_mapping)
    # generate the mapping
    sb_element_one_0.map_input_to_config()
    # output the bitstream
    print(sb_element_one_0.output_bitstream())

if __name__ == '__main__':
    main()