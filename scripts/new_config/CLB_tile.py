from SliceL import *

# the CLB Tile class
class CLBTile():

    # init
    def __init__(self, S_XX_BASE, debug=False):
        self.debug = debug
        self.S_XX_BASE = S_XX_BASE
        # each clb tile contains
        self.cb_east = list()
        self.sb = list()
        self.cb_north = list()
        self.slicel = SliceL(self.S_XX_BASE, self.debug)

    # generate bitstream for this clb tile
    def output_bitstream(self):
        return self.cb_east.output_bitstream() + self.sb.output_bitsream() + \
               self.cb_north.output_bistream() + self.slicel.output_bitstream()