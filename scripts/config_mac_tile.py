#!/usr/bin/env python3
# Hello and welcome to my proof of concept?

import collections
import re
import math
from enum import Enum
from optparse import OptionParser
import os
import sys

# Our Config superclass.
from config import Config

def show_version():
    print('nope')

class ConfigTileConfig(Config):
    def __init__(self, instance_name):
        super().__init__(instance_name)

    def Configure(self):
        final = dict()
        # This is 'input_mux' in the config tile code.
        final['set_soft'] = int(self.keys.get('set_soft', 0))
        # This is 'mem_ctrl' in the config tile code.
        final['disable_mem_shift'] = int(self.keys.get('disable_mem_shift', 0))
        return '{set_soft:01b}{disable_mem_shift:01b}'.format(**final)


class DisjointSwitchBoxConfig(Config):

    class Direction(Enum):
        NORTH = 0
        SOUTH = 1
        EAST = 2
        WEST = 3

    CONNECT_RE = re.compile('connect_wire_(\d+)_(\S+)_(\S+)')

    DIRECTION_BIT_MAP = {
        Direction.EAST: {
            Direction.NORTH: 0,
            Direction.SOUTH: 1,
            Direction.WEST: 5
        },
        Direction.NORTH: {
            Direction.WEST: 3,
            Direction.SOUTH: 4
        },
        Direction.SOUTH: {
            Direction.WEST: 2
        }
    }

    def __init__(self, instance_name):
        super().__init__(instance_name)
        self.SWITCHES_PER_JUNCTION = 6
        self.W = 192 + 2
        self.CONF_WIDTH = self.W * self.SWITCHES_PER_JUNCTION

    def Configure(self):
        # For each wire in/out of the box, there are 6 possible connections:
        #   north/south, east/west, west/north, west/south, east/north,
        #   east/south.
        #
        # The i-th wire in any direction can only connect to the i-th wire in
        # any other direction, so our configuration is limited to picking the
        # wire and then picking which directions it connects to.
        #
        # We can specify this withy the text config:
        #       .djaroni.connect_wire_0_east_west
        #       .djaroni.connect_wire_1_east_west
        #       .djaroni.connect_wire_2_east_west
        #       .djaroni.connect_wire_3_north_south
        #       .djaroni.connect_wire_4_north_south
        #       .djaroni.connect_wire_5_north_south
        #
        # It doesn't matter which way around the directions are specified.
        
        config_bits = self.CONF_WIDTH * [0]

        # Determine which wires are connected.
        connections = collections.defaultdict(lambda: collections.defaultdict(dict))
        for k, v in self.keys.items():
            if v != 1:
                continue
            match = self.CONNECT_RE.match(k)
            if not match or len(match.groups()) != 3:
                print('Cannot make sense of this config line: {}'.format(k))
                continue
            if match:
                wire = int(match.group(1))
                # Sorted so order doesn't matter.
                left_key, right_key = sorted(match.groups()[1:3])
                left = DisjointSwitchBoxConfig.Direction[left_key.upper()]
                right = DisjointSwitchBoxConfig.Direction[right_key.upper()]
                # print('Connecting wire {} {} <-> {}'.format(wire, left_key, right_key))
                connections[wire][left][right] = 1

        for w, left_and_right in connections.items():
            for left, right_and_value in left_and_right.items():
                for right, value in right_and_value.items():
                    dir_bit = DisjointSwitchBoxConfig.DIRECTION_BIT_MAP[left][right]
                    config_index = w * self.SWITCHES_PER_JUNCTION + dir_bit
                    # print('Setting bit {} = {}'.format(config_index, value))
                    config_bits[config_index] = value

        return ''.join(str(c) for c in reversed(config_bits))


class DataConnectionBlockConfig(Config):
    
    EXT_TO_IN_KEY_RE = re.compile('connect_ext_(\d+)_to_input_(\d+)')
    OUT_TO_EXT_KEY_RE = re.compile('connect_output_(\d+)_to_ext_(\d+)')

    def __init__(self, instance_name):
        super().__init__(instance_name)
        self.W = 192        # The number of wires connecting in/out of the block.
        self.WW =  8        # Word width.
        self.DATAIN = 8     # The number of words at the input.
        self.DATAOUT = 16   # The number of words at the output.

    def Configure(self):
        # Each wire north is connected to a wire south.
        #
        # The inputs and outputs are organised into words to reduce the
        # number of switches.
        # 
        # It's probably easiest to define connection of input words to MAC
        # words and vice versa.
        #
        # e.g. To connect North/South word 0 to mac input 0:
        #       .dataroni.connect_ext_0_to_input_0
        #       .dataroni.connect_ext_1_to_input_1
        #       .dataroni.connect_ext_2_to_input_2
        #       .dataroni.connect_ext_3_to_input_3
        #       .dataroni.connect_ext_4_to_input_4
        #       .dataroni.connect_output_0_to_ext_0
        #       .dataroni.connect_output_1_to_ext_1
        #       .dataroni.connect_output_2_to_ext_2
        #       .dataroni.connect_output_3_to_ext_3

        config_bits = self.W * (self.DATAIN + self.DATAOUT) * [0]
        
        # Find defined keys.
        ext_to_in = []
        out_to_ext = []
        for k, v in self.keys.items():
            if v != 1:
                continue
            ext_match = self.EXT_TO_IN_KEY_RE.match(k)
            if ext_match:
                ext_to_in.append(ext_match)
                continue
            out_match = self.OUT_TO_EXT_KEY_RE.match(k)
            if out_match:
                out_to_ext.append(out_match)

        for match in ext_to_in:
            external_word = int(match.group(1))
            input_word = int(match.group(2))
            for i in range(self.WW):
                mac_input_index = input_word * self.WW + i
                external_index = external_word * self.WW + i
                config_index = external_index + input_word * self.W
                config_bits[config_index] = 1
                #print('connecting external bit {} to mac input bit {}; setting bit {}'.format(external_index, mac_input_index, config_index))

        config_offset = self.DATAIN * self.W
        for match in out_to_ext:
            output_word = int(match.group(1))
            external_word = int(match.group(2))
            for i in range(self.WW):
                mac_output_index = output_word * self.WW + i
                external_index = external_word * self.WW + i
                config_index = external_index + output_word * self.W + config_offset
                config_bits[config_index] = 1
                #print('connecting mac output bit {} to external bit {}; setting bit {}'.format(mac_output_index, external_index, config_index))

        return ''.join(str(c) for c in reversed(config_bits))


class MacClusterConfig(Config):

    class WidthMode(Enum):
        '''From mac_team/src/mac_const.vh'''
        SINGLE = 0
        DUAL = 1
        QUAD = 2

    def __init__(self, instance_name):
        super().__init__(instance_name)
        self.MAC_CONF_WIDTH = 4
        self.MAC_MIN_WIDTH = 8
        self.MAC_MULT_WIDTH = 2*self.MAC_MIN_WIDTH
        self.MAC_ACC_WIDTH = 2*self.MAC_MULT_WIDTH
        self.MAC_INT_WIDTH = 5*self.MAC_MIN_WIDTH

    def Configure(self):
        # Use static configuration and given keys to set configuration
        # bitstream bits.
        #
        # | initial3 | initial2 | initial1 | initial0 | signed | accumulate | width_mode |

        # When this bit is 0, the block accumulates. If 1, it only multiplies.
        final = dict()
        final['acc_width'] = self.MAC_ACC_WIDTH
        final['initial3'] = int(self.keys.get('initial3', 0))
        final['initial2'] = int(self.keys.get('initial2', 0))
        final['initial1'] = int(self.keys.get('initial1', 0))
        final['initial0'] = int(self.keys.get('initial0', 0))
        final['signed'] = int(self.keys.get('signed', 0))
        final['accumulate'] = int(self.keys.get('accumulate', 0))
        width_mode_key = self.keys.get('width_mode', 'SINGLE')
        try:
            final['width_mode'] = MacClusterConfig.WidthMode[width_mode_key].value
        except Exception as err:
            print('Unrecognised MAC cluster width mode: {}; {}'.format(width_mode_key, err))
            sys.exit(1)

        return ('{initial3:0{acc_width}b}'
                '{initial2:0{acc_width}b}'
                '{initial1:0{acc_width}b}'
                '{initial0:0{acc_width}b}'
                '{signed:01b}'
                '{accumulate:01b}'
                '{width_mode:02b}'.format(**final))


# Here we manually encode our configuration for the Verilog mac_tile module
# (and its constituents).
class MacTileConfig(Config):
    def __init__(self, instance_name):
        super().__init__(instance_name)
        self.DCB_NS_W = 128
        self.IX_IN_OUT_W = self.DCB_NS_W + 2

        # TODO(aryap): Use instance names from the mac_tile verilog description
        # to hopefully automatically generate this one day.

        # This order is defined by the fact that the config block shifts
        # config into the combinatorial config bits before the memory config
        # bits. The combinatorial config bits set the DCB and DSB configs in
        # that order.
        self.children['configuroni'] = ConfigTileConfig('configuroni')
        self.children['dataroni'] = DataConnectionBlockConfig('dataroni')
        self.children['djaroni'] = DisjointSwitchBoxConfig('djaroni')
        self.children['macaroni'] = MacClusterConfig('macaroni')

    def ConfigureEach(self):
        return [(instance, c.Configure()) for instance, c in self.children.items()]

    def Configure(self):
        # Because self.children is an OrderedDict, the order of configuration
        # streams here should depend on the order in which the children were
        # added to the dictionary.
        return ''.join(c for _, c in self.ConfigureEach())


def main():
    optparser = OptionParser()
    #optparser.add_option('-v', '--version', action='store_true', dest='showversion',
    #                     default=False, help='Show the version')
    optparser.add_option('-H', '--human-readable', action='store_true', dest='human_readable',
                         default=False, help='Produce human-readable ASCII')

    opts, args = optparser.parse_args()

    keys = dict()

    file_list = args
    for config_file in file_list:
        if not os.path.exists(config_file):
            raise IOError('file not found: %s'.format(config_file))

        for line in open(config_file):
            if line.startswith('#'):
                # Comment
                continue
            split = line.split('=')
            if len(split) == 1:
                keys[split[0].strip()] = 1
            elif len(split) == 2:
                key, value = split
                keys[key.strip()] = value.strip() or 1
            else:
                print('Unrecognised config line: %s'.format(line))

    config = MacTileConfig('mac_tile')
    config.Load(keys)

    # config.Show()

    if opts.human_readable:
        for instance, bitstream in config.ConfigureEach():
            print('{} ({}):'.format(instance, len(bitstream)))
            GROUP=8
            LINE_WIDTH=GROUP*8
            for i in range(math.ceil(len(bitstream) / LINE_WIDTH)):
                line = bitstream[i*LINE_WIDTH:(i+1)*LINE_WIDTH]
                num_groups = math.ceil(LINE_WIDTH/GROUP)
                words = []
                for j in range(num_groups):
                    words.append(line[j*GROUP:(j+1)*GROUP])
                print(' '.join(words))
            print()
    else:
        bitstream = config.Configure() 
        # White-space separate every binary value so that it can be read by
        # $readmemb in a verilog testbench.
        #
        # The bitstream is written in reverse order. This makes it possible to
        # stream the file without having to buffer and then reverse it. The
        # first entry in the file is the first value to be shifted into the
        # fabric.
        print('\n'.join(reversed(bitstream)), end='')


if __name__ == '__main__':
    main()
