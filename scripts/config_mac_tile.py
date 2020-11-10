#!/usr/bin/env python3
# Hello and welcome to my proof of concept?

from enum import Enum
from optparse import OptionParser
import os
import sys

# Our Config superclass.
from config import Config

def show_version():
    print('nope')


class DisjointSwitchBoxConfig(Config):
    def __init__(self, instance_name):
        super().__init__(instance_name)


class DataConnectionBlockConfig(Config):
    def __init__(self, instance_name):
        super().__init__(instance_name)
        self.W = 128
        self.WW =  8
        self.DATAIN = 8
        self.DATAOUT = 16


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
        # | initial3 | initial2 | initial1 | initial0 | signed | multiply_only | width_mode |

        # When this bit is 0, the block accumulates. If 1, it only multiplies.
        final = dict()
        final['acc_width'] = self.MAC_ACC_WIDTH
        final['initial3'] = int(self.keys.get('initial3', 0))
        final['initial2'] = int(self.keys.get('initial2', 0))
        final['initial1'] = int(self.keys.get('initial1', 0))
        final['initial0'] = int(self.keys.get('initial0', 0))
        final['signed'] = int(self.keys.get('signed', 0))
        final['multiply_only'] = int(self.keys.get('multiply_only', 0))
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
                '{multiply_only:01b}'
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
        self.children['macaroni'] = MacClusterConfig('macaroni')

    def Configure(self):
        # Because self.children is an OrderedDict, the order of configuration
        # streams here should depend on the order in which the children were
        # added to the dictionary.
        return ''.join(c.Configure() for _, c in self.children.items())

def main():
    optparser = OptionParser()
    #optparser.add_option('-v', '--version', action='store_true', dest='showversion',
    #                     default=False, help='Show the version')

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
    print(config.Configure())

if __name__ == '__main__':
    main()
