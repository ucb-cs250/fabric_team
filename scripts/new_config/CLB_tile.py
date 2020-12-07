from SliceL import *
from CB import *
from SB import *

# the CLB Tile class
class CLBTile():

    # init
    def __init__(self, cord_X, cord_Y, WS, WD, S_XX_BASE, debug=False):
        self.cord_X = cord_X
        self.cord_Y = cord_Y
        self.debug = debug
        self.S_XX_BASE = S_XX_BASE
        # each clb tile contains
        self.cb_east = CB("cb_east", WS=WS, WD=WD, debug=self.debug)
        self.sb = SB("sb", WS=WS, WD=WD, debug=self.debug)
        self.cb_north = CB("cb_north", debug=self.debug)
        self.slicel = SliceL(self.S_XX_BASE, self.debug)

    # report coordinate of the tile within the fabric
    def report_XY(self):
        print("this tile is located on row %d and column %d" % (self.cord_X, self.cord_Y))

    # generate bitstream for this clb tile
    def output_bitstream(self):
        return self.slicel.output_bitstream() + self.cb_north.output_bitstream() +\
               self.sb.output_bitstream() + self.cb_east.output_bitstream()

# a = CLBTile(1,2,4,8,4,False)
# print(a.output_bitstream())
