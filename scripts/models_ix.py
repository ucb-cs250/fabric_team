from config import Config

"""
Configs
"""

# elements for a given config
class IxConfig(Config):
    # five important things we need for a switch box element
    # 1. the width of the connections
    # 2. the available nodes
    # 3. the mapping from node to node (indexed by config bit location)
    # 4. the directioness of the switches
    def __init__(self, instance_name, data_width, nodes, switches, bidirectional):
        super().__init__(instance_name)
        self.data_width = data_width
        self.nodes = nodes 
        self.switches = switches
        self.bidirectional = bidirectional 


# method that generates a type of ix config based on the parameter passed in
def generate_config(type_name):
    name = str(type_name)
    if name == "switch_box_element_one_config":
        return IxConfig(
            'switch_box_element_one_config',
            1,
            {1:"north", 2:"south", 3:"east", 4:"west"},
            [(1,3), (2,3), (2,4), (1,4), (1,2), (3,4)],
            True
        )
    elif name == "switch_box_element_two_config":
        return IxConfig(
            'switch_box_element_two_config',
            1,
            {1:"north0", 2:"north1", 3:"south0", 4:"south1", 5:"east0", 6:"east1", 7:"west0", 8:"west1"},
            [(1,5), (3,6), (4,8), (2,7), (2,6), (4,5), (3,7), (1,8), (1,3), (6,8), (2,4), (5,7)],
            True
        )
    else:
        # default config is used
        return IxConfig(
            "default_config",
            1,
            {1:"north", 2:"south"},
            [(1,2)],
            True
        )


"""
Models
"""

# model this switch box
class SwitchBox():
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