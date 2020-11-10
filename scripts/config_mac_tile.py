#!/usr/bin/env python3
# Hello and welcome to my proof of concept?

import collections
from optparse import OptionParser
import os
import sys

def show_version():
    print('nope')


class Config():
    def __init__(self, instance_name):
        self.instance_name = instance_name
        self.keys = dict()
        self.children = collections.OrderedDict()

    def Load(self, config_dict):
        child_configs = collections.defaultdict(dict)
        for k, v in config_dict.items():
            path = k.split('.')
            if path[0] != self.instance_name and path[0] != '':
                continue
            elif len(path) == 2:
                self.keys[k] = v
            elif len(path) > 2:
                child_name = path[1]
                child_key = '.'.join(path[1:])
                if child_name in self.children:
                    child_configs[child_name].update({child_key: v})
        for child, config in child_configs.items():
            if child in self.children:
                self.children[child].Load(config)

    def Show(self):
        for k, v in self.keys.items():
            print('{}: {} = {}'.format(self.instance_name, k, v))
        for child, config in self.children.items():
            config.Show()


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
    def __init__(self, instance_name):
        super().__init__(instance_name)
        self.MAC_CONF_WIDTH = 3
        self.MAC_MIN_WIDTH = 8
        self.MAC_MULT_WIDTH = 2*self.MAC_MIN_WIDTH
        self.MAC_ACC_WIDTH = 2*self.MAC_MULT_WIDTH
        self.MAC_INT_WIDTH = 5*self.MAC_MIN_WIDTH

    def Configure(self):
        # Use static configuration and given keys to set configuration
        # bitstream bits.
        #
        # | acc3_init | acc2_init | acc1_init | acc0_init | mode_config |
        mac_or
        mode_config = self.keys.get('mode', default=0)
        return ('{self.MAC_ACC_WIDTH:b}'
                '{self.MAC_ACC_WIDTH:b}'
                '{self.MAC_ACC_WIDTH:b}'
                '{self.MAC_ACC_WIDTH:b}'
                '{self.MAC_CONF_WIDTH:b}'.format(



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

    def Configure():
        # Configure self.
        pass

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
    config.Show()

if __name__ == '__main__':
    main()