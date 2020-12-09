from CLB_tile import *

# the fabric class
class Fabric():

    # init
    def __init__(self, num_rows, num_cols, WS, WD, S_XX_BASE, debug=False, top_level_debug=False):
        self.num_rows = num_rows
        self.num_cols = num_cols
        self.S_XX_BASE = S_XX_BASE
        self.debug = debug
        self.top_level_debug = top_level_debug
        self.WS = WS
        self.WD = WD
        self.clb_tile_array = list()

        # init every tile and build up the array (flattened)
        for i in range(0, self.num_rows):
            for j in range(0, self.num_cols):
                self.clb_tile_array.append(CLBTile(i, j, self.WS, self.WD, self.S_XX_BASE, self.debug))

    # get a particular slicel: row, col are zero indexed
    def get_slicel(self, row, col):
        # return a particular slicel
        return self.clb_tile_array[row * self.num_cols + col].slicel

    # get a particular SB
    def get_sb(self, row, col):
        # return a particular SB
        return self.clb_tile_array[row * self.num_cols + col].sb

    # get the east CB
    def get_cb_east(self, row, col):
        # return a particular CB in east direction
        return self.clb_tile_array[row * self.num_cols + col].cb_east

    # get the north CB
    def get_cb_north(self, row, col):
        # return a particular CB in north direction
        return self.clb_tile_array[row * self.num_cols + col].cb_north

    def dump_sync_output(self):
        result = ""
        for col in range(self.num_cols):
            for row in range(self.num_rows):
                result += self.clb_tile_array[row * self.num_cols + col].slicel.dump_sync_output()
        return result

    def dump_comb_output(self):
        result = ""
        for col in range(self.num_cols):
            for row in range(self.num_rows):
                result += self.clb_tile_array[row * self.num_cols + col].slicel.dump_comb_output()
        return result

    # generate bitstream for the entire fabric, from 00, 01, 02, ..., 0y, then 10, 11, ..., 1y, then, ..., x0, x1, ..., xy
    def output_bitstream(self):
        result = ""
        for item in self.clb_tile_array:
            result += item.output_bitstream()
        return result

    # generate column wise bitstream
    def output_column_wise_bitstream(self):
        result = ""
        # MSB                    LSB
        # <CLBTILE col0>         <CLBTILE colN>
        for col in range(0, self.num_cols):
            # MSB                    LSB
            # <CLBTILE rowN>         <CLBTILE row0>
            #for row in range(self.num_rows-1, -1, -1):
            for row in range(self.num_rows):
                tile = self.clb_tile_array[row * self.num_cols + col]
                # MSB                       LSB
                # <cb_east> <sb> <cb_north> <slicel>
                stream = tile.output_bitstream()
                if self.top_level_debug:
                    print("generating bitstream for clb tile on row %d and col %d: %s" % (row, col, stream))
                result += stream
        return result

    # reset
    def reset(self):
        pass


# a = Fabric(2,4,4,8,4,False,True)
# a.output_column_wise_bitstream()
