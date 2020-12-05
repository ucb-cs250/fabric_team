from CLB_tile import *

# the fabric class
class Fabric():
    
    # init
    def __init__(self, num_rows, num_cols):
        self.num_rows = num_rows
        self.num_cols = num_cols
        self.clb_tile_array = list()
        
        # init every tile and build up the array (flattened)
        for i in range(0, self.num_rows*self.num_cols):
            self.clb_tile_array.append(CLBTile())

    # get a particular slicel
    def get_slicel(self, row, col):
        # return a particular slicel
        pass

    # get a particular SB
    def get_sb(self, row, col):
        # return a particular SB
        pass

    # get the east CB
    def get_cb_east(self, row, col):
        # return a particular CB in east direction
        pass

    # get the north CB
    def get_cb_north(self, row, col):
        # return a particular CB in north direction
        pass    

    # generate bitstream for the entire fabric
    def output_bitstream(self):
        result = ""
        for item in self.clb_tile_array():
            result += item.output_bitstream()
        return result